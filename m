Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A74E9D5F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 15:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfJ3OXj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 10:23:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46982 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfJ3OXj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 10:23:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id e66so2836237qkf.13
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Iieil+MuDaNJ5lIJEOFs9h7jIoiG48MeHaP0+PASXlo=;
        b=bf2xTGjUYAa3MySkebfnobaQ/S7IFbvS3B8bSmpGJw21kTSBXvaEKLTGw+yavb0Dgz
         Dw/dnD8CYZHxAuOvQrPSFUCZ/ggeRfDkgx444Sojdaa90kTduIlrOB9d69bpjAFWkAgO
         iFKxRGN/WlM09anCsNQxhTKqBBTNObXzGqksZXZh1y5Xyh6UO+8EEv//zy84HhvzsJuH
         iFKxK5PG0h0u0HO4h2JNTDGyeCbdkQ8QXHSdoDGDWM/zmThHe8lsMzrqI0qeHYlwKq7s
         FFlVfJs/amMOXNIROl2Hq0GlFPvtATS00Dv6LBb+lrMpb0tttEUpSE03ufeyFMA9BRDT
         7r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Iieil+MuDaNJ5lIJEOFs9h7jIoiG48MeHaP0+PASXlo=;
        b=cphJzfX+27hn+QIDxf9xZ2+OB95ZXaxRJhxktUBK6RMYE9SBJG8xwy3wAAMM9ZzsZq
         r8ktJ3kXvb0STHMuMHjKKjhKYmayB6Ad1WFtZ5hV2ZhFIfduCKxvdQDuJCZoLjgiSuH/
         dqMOj+9rBnoMFKt3d1UryAuvgBGOC6Fqcc4j8jgEayB1P4ppdjFvcKbbNIfynYjUW4n/
         RlQ+UClCFEUqw50NDSICE4hl+0+TDskf0QbF5Xn03x5LtgE8oQyACCG4OcOMgVabb+LF
         fYBJy4Epncjo1SWfYtejOgfUP2NL1Y+9Ary/0NbcRHekCpVXN8ydPjrtydrslJPWqiFD
         2Uig==
X-Gm-Message-State: APjAAAVoXDvuzg/jubJwPK2v5+aWLh8RltbyvkuCtqM7upt2osFa6Scr
        ikVhZvVN8i2La+bKOOjZrYVwpg==
X-Google-Smtp-Source: APXvYqzmbqgk6/kz7QU3nlWaRgKvHPWEG3ZIdKB73xjHpjGorCH8t3zSH+3B/Dh6UH8mTXW9UuCW5g==
X-Received: by 2002:ae9:e713:: with SMTP id m19mr127213qka.338.1572445418273;
        Wed, 30 Oct 2019 07:23:38 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id q4sm219231qtj.41.2019.10.30.07.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 07:23:37 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: Add mx power domain as thermal
 warming device.
To:     Rob Herring <robh@kernel.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-8-git-send-email-thara.gopinath@linaro.org>
 <20191029013111.GA27045@bogus>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DB99CE8.1050506@linaro.org>
Date:   Wed, 30 Oct 2019 10:23:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191029013111.GA27045@bogus>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/28/2019 09:31 PM, Rob Herring wrote:
> On Wed, Oct 16, 2019 at 03:37:21PM -0400, Thara Gopinath wrote:
>> RPMh hosts mx power domain that can be used to warm up the SoC.
>> Add sub-node to rpmhpd node for mx to be recognized
>> as thermal warming device on sdm845.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 0222f48..0671c8a 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -3788,6 +3788,11 @@
>>  						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
>>  					};
>>  				};
>> +
>> +				mx_cdev: mx {
>> +					#cooling-cells = <2>;
>> +					.name = "mx";
> 
> Copy this from C code?
Hi Rob,

What do you mean ?

> 
>> +				};
>>  			};
>>  
>>  			rsc_hlos: interconnect {
>> -- 
>> 2.1.4
>>


-- 
Warm Regards
Thara
