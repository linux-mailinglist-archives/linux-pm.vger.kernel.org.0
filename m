Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A554A70B70B
	for <lists+linux-pm@lfdr.de>; Mon, 22 May 2023 09:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjEVHv2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 May 2023 03:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjEVHvH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2023 03:51:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1410F3
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2023 00:49:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-309550d4f73so2039245f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2023 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684741708; x=1687333708;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8dj8yxA8aTR556/ywnr0LTSwlcZxI32LcOw4Zuf/m8=;
        b=MioEID9u6itRUSE9iD5ycmvk1UKAPr15DXwMmPU2p1DaUF4zsNMd+lxYcD2Ie36Deq
         tq1nbbuomtFiqSq+zorMeM3IHxy+kkHJjQEGcGLWkW2QovESxXAtno5CJ7j9OUxKAwhi
         yBmfxiewLtrXigjswJLJVSsB36bMw2/xRctH+klR7urSzrKyqPWMulK305FJVaaC2l80
         jWKKLNzF5ctwTvfR70v21k/qy9nISQzURWbWVJpEWkAXKatFWoem8KUHq2n8H4WVEm3h
         lZUcOl7z0Ip2uN01LxVF5cnu2m2rnEmOqXhwpLB/lHUYiUtVh9mrzsSrpFNrSsRZPG9Y
         ecZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684741708; x=1687333708;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8dj8yxA8aTR556/ywnr0LTSwlcZxI32LcOw4Zuf/m8=;
        b=Ai8ASybPfViKmHT4HzEqaO2+Y8CWN1tR7MxGjAGxvnmyoLRo8YsnwovgIFDedLBsWe
         UYaoFNkzlGj+nfqaDg6wK5HKzSaXUFeha7aWENQOLgoSsQ1tBGPJ0Ud/zzyFPfVtO7ek
         Kbx9FjAbnruzOgvW9Qp6nfaNu6arG7Vo8hIwhc6+c5jBCSeg/sBMwt2+jBCaZDLmdPfO
         24QzSTfrmrYCZE84Z2wGK3mKHpjSoPhFdRp+CvBmppj3xbyrOa3JPy8brjuzXmbtajVR
         8c6ffA2K52FTIh8GYCt3DgdX/33b665RmGa64AFLR8Cun3HzP1gSCQ/VkOC42RwWh0HD
         oPTg==
X-Gm-Message-State: AC+VfDzyixhev0G1jBlhdaiGlNmJEoML93kwDzreKCqFnnvyYDuB8/yo
        2DdlIDk8Qnffu4Eswcg7aP6rGA==
X-Google-Smtp-Source: ACHHUZ50N1YblPjsdry9S5GwGyC3kPtnmgqDIwZKDz4lleoi3tlCpsFTeTnW6JHAUEbE2t6e9RZutA==
X-Received: by 2002:a05:6000:1002:b0:307:c0c4:1094 with SMTP id a2-20020a056000100200b00307c0c41094mr6873367wrx.34.1684741708134;
        Mon, 22 May 2023 00:48:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d56c4000000b003062d815fa6sm6777613wrw.85.2023.05.22.00.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:48:26 -0700 (PDT)
Date:   Mon, 22 May 2023 10:48:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] PM: domains: Allocate governor data dynamically based
 on a genpd governor
Message-ID: <5c11bb92-313e-43c9-8ac5-ea95810a27a7@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Ulf Hansson,

This is a semi-automatic email about new static checker warnings.

The patch f38d1a6d0025: "PM: domains: Allocate governor data 
dynamically based on a genpd governor" from May 11, 2022, leads to 
the following Smatch complaint:

    drivers/base/power/domain.c:1635 genpd_add_device()
    warn: variable dereferenced before IS_ERR check 'genpd' (see line 1629)

drivers/base/power/domain.c
  1628	{
  1629		struct genpd_governor_data *gd = genpd->gd;
                                                 ^^^^^^^^^
Patch adds a dereference

  1630		struct generic_pm_domain_data *gpd_data;
  1631		int ret;
  1632	
  1633		dev_dbg(dev, "%s()\n", __func__);
  1634	
  1635		if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
                                   ^^^^^
Checked too late.

  1636			return -EINVAL;
  1637	

regards,
dan carpenter
