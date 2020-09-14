Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BDD268D99
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgINO2k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 10:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgINO2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 10:28:16 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D5BC06174A;
        Mon, 14 Sep 2020 07:28:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w11so13678547lfn.2;
        Mon, 14 Sep 2020 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a9JhPXmtDMQl39tV6r+JtAvNls1OvzKuICOGpS3XJk0=;
        b=bIfiN/rWDpEnFzhemuaUXSjV+bijsLDTHiMSOGMN/h+y0Ez4DIppYxF+wQ+x32Oov3
         pZIWpU6P+5RCllnzLruUcaqCNRmPXxJ3hbTvpU+7e6VvcsWorPe63/X4PuPKehXrTJFP
         HQE7ieCOmHSUTVqjVjvTVRBsE2w753lEcnNfXjS8GT+lzkerC3DGNC1nMsfaOHaTFKJs
         HNWbgtjmjkd6FZryz4z9rE7T5O4vRRNH25WJxaqu4NaHHY+CY8/qtRtbMwpEG/RhzGM5
         d9GKeS94UcFvE1vNCHOg+K5ikshr+Mn6HcKVVMuMknThU/gndLzy7yW6KWwHdOihJWsf
         uAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a9JhPXmtDMQl39tV6r+JtAvNls1OvzKuICOGpS3XJk0=;
        b=B1NH3lgQ0vtw2X44asiDLed6Wya29yvNygCQu7P3m+x1yTWUmiFiB0MnL0AUK/POoA
         c7m+640nTVQvsh6lXAJktyk7FcwjyNTifsBDITjxG/JRS9cleoaWJHhzlubs5wrCCkKg
         OL4Ba0q0NV2BCxrmL+xRUnUJBUTR3KcmJM0OYIvJBKRqTNPn7DiS4Kkc5lFHpg5Eqyik
         uLPTkMPMiSSUom8EgeVrVH1C+ve4En1NqVzIp8d+JnlDln71kF1j6sR9CkSgO8kCCg+Z
         vRPhSBd2bRbfIVa0QIVAFOS/Q155JEKRhM6oOEwMvM220n00Yp10qGh+c66MJmH8IwCA
         2iEQ==
X-Gm-Message-State: AOAM532WclaPIRUXv7Mb1LGp5fKY5oc1DmU6w1aQPiLmYi/Gjn65BjB1
        9CaQ4iC4x5hDguJwpkrkxAGMFaUtW9k=
X-Google-Smtp-Source: ABdhPJw473AXuMouDoixI6tu95sUvsTpLM5Scs9mrMq/bmPR/EKAyQ1blmmM3taS/5NyuiMTg+bgXg==
X-Received: by 2002:a19:650a:: with SMTP id z10mr2479151lfb.9.1600093693097;
        Mon, 14 Sep 2020 07:28:13 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id z3sm4073281ljm.76.2020.09.14.07.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 07:28:12 -0700 (PDT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <CGME20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7@epcas1p4.samsung.com>
 <20200908072557.GC294938@mwanda>
 <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
 <44560522-f04e-ade5-2e02-9df56a6f79ba@gmail.com>
 <20200914141754.GB18329@kadam>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c0621c79-00e4-0fec-c98e-b46e231b30ef@gmail.com>
Date:   Mon, 14 Sep 2020 17:28:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914141754.GB18329@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.09.2020 17:17, Dan Carpenter пишет:
...
>>> Is it doesn't need to reset with reset_contrl_reset()?
>>
>> Hello, Chanwoo!
>>
>> It's reset just before the clk_round_rate() invocation, hence there
>> shouldn't be a need to reset it second time.
> 
> Ah...  I was looking the wrong code.  Plus I don't really know this code
> very well.
> 
> If clk_prepare_enable() fails, then I would have assumed we need to call
> reset_control_deassert().  I would have assumed the
> reset_control_assert() and _deassert() functions were paired.  So what
> I'm suggesting is something like the following:  (I'll resend this if
> it's correct).

The reset shouldn't be deasserted if clk-enable fails.

Reset deassertion should be done only with enabled clock because reset
happens synchronously with a clock tick, otherwise it makes no much
sense to deassert the reset.

Yours current v1 variant is already good to me.
