Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78487E4E7F
	for <lists+linux-pm@lfdr.de>; Wed,  8 Nov 2023 02:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjKHBPW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Nov 2023 20:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjKHBPV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2023 20:15:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B3810CF
        for <linux-pm@vger.kernel.org>; Tue,  7 Nov 2023 17:15:19 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40806e4106dso1447825e9.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2023 17:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699406118; x=1700010918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZnznCqM2AjhaZi79PbuLHcHUwpNTpzbw/YuXnI5mfQ=;
        b=A2okkFp7TX/st0lbMUu2UPI+8NYPHjuLjE/StjD2LuiCQHGOvv44FL84gtaP0OgSZe
         T6gvaK0gzSUqdBMTKJY6sg1Wfejy8xZCtHMTKhYB91JJ+Mqyn/n6aprV2F2TANk79UAm
         HRX2bLe7tF4+d8TVDmfEjIXu7p/OSM4O1tGEuUi4qNjqGdOM8HXQBrf8YhI75KrQ5MVF
         u3Etx60oeKmyFGdScAnvAu71GzJjpMUi781RLWcyw1SYf/1YNPOUhdIRZtREhNuevuNJ
         BYUOx11YReIQ7KSs2gTGv7uqzfayDIU6C0wpCRQ700VjNUUuhQbiWkxA9bLsa6ibw6fD
         z5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699406118; x=1700010918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZnznCqM2AjhaZi79PbuLHcHUwpNTpzbw/YuXnI5mfQ=;
        b=q1UTyx5pykcanBQLd1fBxAOOC5rcks6hWjfBK8tghTMzxO/vM420TrlrFdL9soRgbD
         TR4nAUsJqEnZ6YmqL3MrKMddbVmY/i4FPJwa9XSELPvg3zJLHc0e09DKo5+BGKkMVAFz
         aLQ7PRlDuuUHodwB2EgYrYS24vi8jn9npZkR+RQz1aiGhYiAx/lnXsLtXcJmQNIge7QB
         VNuAs9EOuAi3JmjRGZldzrJEqPxS6TOKrIfoRAsnejBXvmmeFqHovheTNoiVbGuTA/QX
         7zXT7ivWi7UGIBoVzrGfretMGBS+va9v8jTz8cgziZepldCYQsVXpcuZ6nE5/GAOC5F1
         9eyg==
X-Gm-Message-State: AOJu0YzYOk2ufyKg5FDMLlsI6ye2puFw263L84W5vgfhcDyrILaBmn1H
        uJJXqlsTJKFRt9NnKC0IR3UZfg==
X-Google-Smtp-Source: AGHT+IEIbjP5ubRLbHFuttHbIGtYyTdvZVb5ctg0N4NF3wFeDFArM4/Br06A2vdI/3SJ+YmATJCpTw==
X-Received: by 2002:a05:600c:c0c:b0:401:b425:2414 with SMTP id fm12-20020a05600c0c0c00b00401b4252414mr4903500wmb.18.1699406117867;
        Tue, 07 Nov 2023 17:15:17 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcc15000000b0040773c69fc0sm17049309wmh.11.2023.11.07.17.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 17:15:17 -0800 (PST)
Message-ID: <ae95c3c7-26b7-42f5-b806-f57b56e6300e@linaro.org>
Date:   Wed, 8 Nov 2023 01:15:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to
 switch video GDSC to HW mode
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
 <20231101-gdsc-hwctrl-v3-4-0740ae6b2b04@linaro.org>
 <835a6add-81e9-42e4-abbe-91632aaa6bc9@linaro.org>
 <82a25b12-7a63-4c75-8a46-624bc35c6752@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <82a25b12-7a63-4c75-8a46-624bc35c6752@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/11/2023 21:21, Konrad Dybcio wrote:
>>
>> So.
>>
>> I'm assuming the rest of this series works however for sc8250 at least 
>> this is a NAK, breaks venus on rb5.
> Are you saying that applying this patch alone causes the attached crash?
> 
> Konrad

I tried to revert this patch in isolation and got

->

[  157.083287] qcom-venus aa00000.video-codec: Failed to switch 
power-domain:1 to SW mode
[  162.004630] qcom-venus aa00000.video-codec: Failed to switch 
power-domain:1 to SW mode

I stopped debugging there.

---
bod
