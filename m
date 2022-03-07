Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD5E4CF171
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 06:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiCGFxN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 00:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiCGFxL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 00:53:11 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AA35D659
        for <linux-pm@vger.kernel.org>; Sun,  6 Mar 2022 21:52:18 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d187so12794264pfa.10
        for <linux-pm@vger.kernel.org>; Sun, 06 Mar 2022 21:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ug00C0TLqhMQFVRMFl4wzRsq93sEkVz4GF6pOmW3fxo=;
        b=ORj58dgiICK4BAz457mklGokk8GqtxMq4KiofTaZ+jwDFCpEmEl+afUL09Si8xqHlU
         zWOPhmlo1xg1vH+z0+JxbZrC3OR06F7H9jNk58OnJ1R0JAIRRvohGFjlVrTUfQN5LM8T
         nEAGZ0JmS5RcbV/hm+p89949aHvfFX+R3fE9vbOozOdkIdGbRcboCX9r4yGQj8l25pA5
         +PSauTsaIDrxUy/HfyE1sZJh0K+MoOrT0iCh7aKuWnPTc8VcB1766wh3XeMVcdTvn82c
         FPyCqBCOAbbHkFX9W19S8i5DpzILw6YpkD7U8YjZDh+LoHvdXacYN7rEU+akLt9fmpON
         VuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ug00C0TLqhMQFVRMFl4wzRsq93sEkVz4GF6pOmW3fxo=;
        b=MkZ0+AuiB+xvXzRvTKIRJFMeIbBDt1lCNFrtaM0jYYUQVYhYhXvnRFB5sPEeFxLHkE
         s7LmISAzL1YNiypezi7KiBlVuq+YqQATLRpdififS20knRBXjt74QyzAE306QeJI0O1b
         3Jd2SQOHYlLqYEY25M42OYvcl8hItu+RclvfYlf34p5tOP0MwE4OBj4Cz15Xcm1ZrICn
         mb914bkn4+OzVMBLS4L6EYOhxgPavT3BFNelQL6N8RQ+Qi8qVwjLHlWTiAujGz7KgK1z
         xruhH7Ki4Qa10zsVHA6jPH3OPmSmSpdABmw8n9M6LB+PaoOy/okuqIvEri07jXpGW6U/
         i+xA==
X-Gm-Message-State: AOAM532EKDNMp1B9gb7tUwkJ5geMkf296P2SsTrLal9svAzijhrYhRoU
        Qk3PSO1Pcyd7qbjJNzm2cBgh3A==
X-Google-Smtp-Source: ABdhPJxZciYh+qVPD89mJ0oCH0qoYBdQP1QcrHrfO81wmAx9lQCSWy3OKk/0z9kR+M1+TNJhplE8lw==
X-Received: by 2002:a05:6a00:1991:b0:4f7:1322:ca04 with SMTP id d17-20020a056a00199100b004f71322ca04mr209239pfl.85.1646632338180;
        Sun, 06 Mar 2022 21:52:18 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id p128-20020a622986000000b004e1366dd88esm13530071pfp.160.2022.03.06.21.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 21:52:17 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:22:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     zhanglianjie <zhanglianjie@uniontech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: unify the show() and store() styles of attr
Message-ID: <20220307055216.gh3aiivz7o3tvomr@vireshk-i7>
References: <20220306021250.64315-1-zhanglianjie@uniontech.com>
 <20220307053931.kkhnxrujljynp5cz@vireshk-i7>
 <62259d22.1c69fb81.5ba55.5efaSMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62259d22.1c69fb81.5ba55.5efaSMTPIN_ADDED_BROKEN@mx.google.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-03-22, 13:50, zhanglianjie wrote:
> Usually /sys directory under the file, the corresponding Attribute contains
> .show and .store, and their naming style is filename_show() and
> filename_store(). But all naming style in 'cpufreq' is show_filename() and
> store_filename(), So you need to change naming style.

This is something that is present within the kernel and not exposed to
userspace. I don't see why we would need to make this change and what
good it brings.

I would have supported this if cpufreq itself had different names, but
for this one, No.

-- 
viresh
