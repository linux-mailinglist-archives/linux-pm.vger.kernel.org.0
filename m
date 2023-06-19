Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785AA734B0F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jun 2023 06:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjFSEYA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jun 2023 00:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFSEX7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2023 00:23:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E1E4D
        for <linux-pm@vger.kernel.org>; Sun, 18 Jun 2023 21:23:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666ed230c81so1939502b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 18 Jun 2023 21:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687148638; x=1689740638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZRLpHRhAXUY5dus0TvR/zu9JzM6T1mOEJHElmWOWJE=;
        b=HQFfdRHYfeVsV6A9FVlMYIcDjwWvhq4oFZMxLU6IMADC20VRtMoNd6WEmp5JrTK/WE
         u1NNdakLh8TFmPQB2hiv4DYtY608S892I9xHQLryJ1OGnKBpFVHrCQZbmq7qDJkeCJxs
         4FTPj6oqTLJYncnBCq+WlFyXPrQLlPxaKXfK+mRJZMVtMUsE+h/TVoOhq8WaYEAE0xI4
         XzwrJGCi9CNEXvgROUBO52XCLnCGFrYUGS9nSrvbJ8938MQsib5YQjP+TWAWGcrXnNKR
         FXjHFN6d+F3rdkA11pk1Fm5p+nBJosWOjakq44/nDvqNljwsgaDHmNdWPu3lzQ/qJ0dU
         22Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687148638; x=1689740638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZRLpHRhAXUY5dus0TvR/zu9JzM6T1mOEJHElmWOWJE=;
        b=WuzEJu4C29/hq5uWd3y0F5oFlCqrm70p5BsO+eyVCtxi7F5A9JNsvDw4DF4HUUKi88
         skF39eVQKprqcLFNBZ4ccz/JROjqaR8Xpa+cfxGTUMTXsHXsy0+hb2iBab6/7wJkkWQx
         i/u8sdUKBgGDNHUXmpnHfkvWHKZffsZIoOK8YnqqOF+VC+whGnzJRhN0kjFgPH3UBy2L
         /byraKT25E5zfVP4r4e7963JB+3VK9SiJu2CBFdJqgeNOSSZf7eO/qp01WbpE0UAcBW2
         xeR3X8VfULggaiqhXNP7lSJk1j7JlZX0mxK6fQwFVzYwVjRPTdG9RZF0MeMfXzu/rHyS
         ebcg==
X-Gm-Message-State: AC+VfDxc7+6r8RSnfmszcPbUrnOlyFWvQ4uszHnL5KEK1DMitVbF6SRQ
        DuZoyIa7ht+Cz18UvCm+rFM2bCJNzG9jHW0Q9cs=
X-Google-Smtp-Source: ACHHUZ6NLWpKg9SCzfw/4lf3Nr4H8Qlob9ntj4wmqRJSZ27ynSSGqqU/nmc0dvxhJqf3oP2VQYZYww==
X-Received: by 2002:a05:6a00:198f:b0:662:5146:c77a with SMTP id d15-20020a056a00198f00b006625146c77amr12801859pfl.31.1687148637964;
        Sun, 18 Jun 2023 21:23:57 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id t1-20020aa79381000000b0064381853bfcsm16659055pfe.89.2023.06.18.21.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 21:23:57 -0700 (PDT)
Date:   Mon, 19 Jun 2023 09:53:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: mediatek: correct voltages for MT7622 and MT7623
Message-ID: <20230619042355.hbprbr7kty5uznja@vireshk-i7>
References: <9d7e62049e3442582bd64dbc9e4d2a64f1ad0c1a.camel@mediatek.com>
 <ZH3umLU883eGbYBx@makrotopia.org>
 <355198a9-c5f8-3caa-243a-bd0c544caf8d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <355198a9-c5f8-3caa-243a-bd0c544caf8d@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-06-23, 09:41, AngeloGioacchino Del Regno wrote:
> Il 05/06/23 16:18, Daniel Golle ha scritto:
> > The MT6380 regulator typically used together with MT7622 does not
> > support the current maximum processor and SRAM voltage in the cpufreq
> > driver (1360000uV).
> > For MT7622 limit processor and SRAM supply voltages to 1350000uV to
> > avoid having the tracking algorithm request unsupported voltages from
> > the regulator.
> > 
> > On MT7623 there is no separate SRAM supply and the maximum voltage used
> > is 1300000uV. Create dedicated platform data for MT7623 to cover that
> > case as well.
> > 
> > Fixes: 0883426fd07e3 ("cpufreq: mediatek: Raise proc and sram max voltage for MT7622/7623")
> > Suggested-by: Jia-wei Chang <Jia-wei.Chang@mediatek.com>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied. Thanks.

-- 
viresh
