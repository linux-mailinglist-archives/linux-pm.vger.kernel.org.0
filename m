Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B169663FFD2
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 06:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiLBF1Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 00:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiLBF1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 00:27:22 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FFAD15AF
        for <linux-pm@vger.kernel.org>; Thu,  1 Dec 2022 21:27:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k7so3689134pll.6
        for <linux-pm@vger.kernel.org>; Thu, 01 Dec 2022 21:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eSxc/vuw8b8ZlV/zQQB1AHYxMkA7FyAjq/UT8DAx5EM=;
        b=JxjJFek7AAPKxa74aAl5FtksMKDZBRv8UpjC6oDgN8cTcnEoLw1Ea1XvcpICJmfCP/
         B0u5qpGMP6zAnvqu4HscpVX9p3enKr5Ji9GaHQV1SvFteYNQIcjkhB4jZ4jZTaPg6Zu+
         5pMLjpVs2ZOskNgLywnTUs5/YKE964gxJSTMstdhauLcD9QjTTYVDenmBEjTC+k4XgNe
         PTFuOJt+wifphpsprqfu42xfYcMzG9jSudpYrHsfdu0rvxrfvUHJf8V3yJP9BLdW7hJb
         0zm9U5Rzsdc+BjbzYcj2mISlYjxGzgzWFYZGzYcBasXnskxBtAJSbsqztCRjO9MN2VD7
         OUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSxc/vuw8b8ZlV/zQQB1AHYxMkA7FyAjq/UT8DAx5EM=;
        b=6dFo5TbXIxYsoNQYW7rdLy/17usWMnJFO5WXEdY8fRdmBKM3aQtfTtj+tM5vbP0eCe
         NOXwbENSlyBbSG5RZ4RMFIfdK5rKkDukrK7EATrKw0cF4MhqgmJytj8363qzyUL8i0se
         tfrF+6946izo+LafSzu/B/b8R0OUlKuLfM3QAmlH2dwosxhKsML1W9zsLxs+wq+T6Lat
         2Z1VTPIFP0xbZrHWxUexC0qYdzT2PPDRRxhYF+xOwAXAcC6zNZWnpJ+sNxBJ8Syu94R+
         sEFE3kGUFiUpqHuvibMXU0JWxMDFcm8xpJ7dpuEbBX1z7LsmeTgpmLn2VcCkterTZagi
         ePug==
X-Gm-Message-State: ANoB5plx7SGNtA+C8bH9xYc4qHhmQot0RGUV+1f1JVAVlZLKgDDFWvui
        Bvt8Aqmc5pPnKiLaiQLMkCcPBQ==
X-Google-Smtp-Source: AA0mqf4qhJ72iEB1qNdRF4ONDN4xQ7Tu4gAgw2SXdas1iORjFhdOikJ95Q7LaqhRV0EwhSaiwVYZHg==
X-Received: by 2002:a17:90a:5991:b0:218:47f1:b47b with SMTP id l17-20020a17090a599100b0021847f1b47bmr73243982pji.201.1669958839315;
        Thu, 01 Dec 2022 21:27:19 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id b65-20020a62cf44000000b0056f0753390csm4273317pfg.96.2022.12.01.21.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 21:27:18 -0800 (PST)
Date:   Fri, 2 Dec 2022 10:57:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     jia-wei.chang@mediatek.com, Nick <vincent@systemli.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        rex-bc.chen@mediatek.com, angelogioacchino.delregno@collabora.com,
        Frank Wunderlich <frank-w@public-files.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        =?utf-8?B?SMO8aG4s?= Thomas <thomas.huehn@hs-nordhausen.de>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: Kernel Kernel bug caused by (cpufreq: mediatek: Refine
 mtk_cpufreq_voltage_tracking()) on Banana Pi R64 (MT7622)
Message-ID: <20221202052716.uj3kzkunazmgazeq@vireshk-i7>
References: <930778a1-5e8b-6df6-3276-42dcdadaf682@systemli.org>
 <eb142a22-b35e-ec3f-ee0a-9e3e7b24cea6@gmail.com>
 <bf8d2a8f-7654-29be-1104-a842c6657b5e@systemli.org>
 <02c2c955-940b-b315-0474-85d0eddad7a3@leemhuis.info>
 <Y4jHvomTrU8guBox@makrotopia.org>
 <47a4665e-333d-a6e7-a2da-96cb06c2d87b@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a4665e-333d-a6e7-a2da-96cb06c2d87b@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-12-22, 16:39, Thorsten Leemhuis wrote:
> Thx for clarifying. And I noticed I made a mistake: I should have
> directed my earlier question wrt to any progress here more into the
> direction of Jia-Wei Chang (who authored 6a17b3876b) and Viresh Kumar
> (who committed it).

I was waiting for the platform maintainers to come up with a fix. I
have sent a patch now to revert this, in-reply-to this thread.

Please confirm this is working fine. Thanks.

-- 
viresh
