Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D737934C26E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 06:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhC2EMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 00:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2EMB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 00:12:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AC3C061574;
        Sun, 28 Mar 2021 21:12:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 11so9026244pfn.9;
        Sun, 28 Mar 2021 21:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=y2+7B4/FFOunoYP31Pqi6aKbhUuHGTLkLhn/LkVaufA=;
        b=EZH/maXagDYstOHFBmX7RBR7d65+za7CQjgpXV5OtDyYPv4MCH6C/cwZsUOobdBDa1
         r7T25RETwNSGVWIIFHukmDOWwAxsGi3B/0pIWmv4b7OS46UkQ6deiWTWSu34RfQjfYdz
         bi2YUy/DqdrOKsb4xohiwzevWPsZBCMKYmUoIRmOLKYsgrdYNooAV4Q1Q9UV8/LBf7WL
         V/3y1QDIsPNNX++b0kIs9wwudrpDo+RAWMKXYWwEMck6fyHFy2Wl/X4jXaBxt97yi1pU
         YR/ws5pr81XLQqX3mVpFuRY319feH/at7t6SU92Wu8ji0koOEOqB4GWT69K7ggBAJpRz
         rZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=y2+7B4/FFOunoYP31Pqi6aKbhUuHGTLkLhn/LkVaufA=;
        b=jYlcv6CuKnolurQ6s+2eRDxaokWq5VSoAZDMsYZrsr9husEwKFMdZFvZxl7WvUuB+x
         xDr61U2bdU8nMjgXcgJDbmdfd/Jzfe+466uaqefilv94GCwJ4UbQdPt6WQlV3ZPtiriF
         4GYWSF5M92QF/POHY9O2HUjOEXPLunRzYaEfX4PZCZadjG8bSq2PkqgBSKWDMCgrZu4T
         TDu8aclzoG1Tw/VCJ69l0Qf/m/IGJs15k/bLE9JP/sZSIMikpZCKV8h+b4Fet/5+J1LA
         k7ZSsxLGkbWLKB0tFXNE21wIfQLk2nUDH78NtrV3R2TBD8ZIgHD6sQMNX8aqNSFfsq1V
         YeLA==
X-Gm-Message-State: AOAM5327oq4TGOLiDElQ5dTrcvW5u1ogXNHvdi2YRFE8xGZgwFJquw8X
        e6arUYYOpuMu6IiSk9rSLjU=
X-Google-Smtp-Source: ABdhPJwlR9eLuMFpbX+3joQWgdR8GgKtFbb8wAQp3xOl+1elRnHHD3CCnkjgI46QadEEChpyeg69UA==
X-Received: by 2002:a63:5c23:: with SMTP id q35mr22518790pgb.418.1616991119289;
        Sun, 28 Mar 2021 21:11:59 -0700 (PDT)
Received: from MacBook-Pro.local ([122.10.101.130])
        by smtp.gmail.com with ESMTPSA id h19sm15925620pfc.172.2021.03.28.21.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 21:11:58 -0700 (PDT)
Subject: Re: [PATCH 2/2] cpupower: fix amd cpu (family >= 0x17) active state
 issue
To:     Shuah Khan <skhan@linuxfoundation.org>, linux@dominikbrodowski.net,
        sherry.hurwitz@amd.com, trenn@suse.com, linux-pm@vger.kernel.org,
        rrichter@amd.com, nathan.fontenot@amd.com, bp@suse.de,
        latha@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Cc:     lishujin@kuaishou.com
References: <e3f8c0f1-63dc-9b25-7129-d0a4ee87f62a@gmail.com>
 <c85e7ec8-0fef-fbb1-772b-4144774353e1@linuxfoundation.org>
From:   xufuhai <xufuhai1992@gmail.com>
Message-ID: <c28d130a-f971-f334-5ef0-3708688da9e0@gmail.com>
Date:   Mon, 29 Mar 2021 12:11:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c85e7ec8-0fef-fbb1-772b-4144774353e1@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

yeah Shuah~ thanks for your reply

For this issue, not meaning "current CPU frequency" but "boost state support--->Active" during 
"cpupower frequency-info" command as below:

	boost state support:
    		Supported: yes
    		Active: yes/no

I think the state returned from the command for amd cpu (family >= 0x17) should be like as below:

	as non-root Active state:
		Active: Error while evaluating Boost Capabilities on CPU xx -- are you root?
	
	as root Active state:
		Active: yes (if supported)
			no  (if not supprted)

I don't wanna see the state returned like below:
	
	as non-root Active state:
		Active: no
	
	as root Active state:
		Active: yes (if supported)
			no  (if not supprted)
	
I will paste the related code by detailed for showing the issue:
	
	if amd cpu family >= 0x17 , will run read_msr function via read /dev/cpu/%d/msr. For non-root
caller can not open msr node due to having no permission, but cpufreq_has_boost_support will return 0 to 
upper caller function that not means caller no permission to read /dev/cpu/%d/msr. I believe we should
return negative value for the condition:

-----------------------------------------------------
/linux/tools/power/cpupower/utils/helper/misc.c
cpufreq_has_boost_support:
 
	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB) {
		*support = 1;

		/* AMD Family 0x17 does not utilize PCI D18F4 like prior
		 * families and has no fixed discrete boost states but
		 * has Hardware determined variable increments instead.
		 */

		if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
				if (!(val & CPUPOWER_AMD_CPBDIS))
					*active = 1;
			}
		} else {
			ret = amd_pci_get_num_boost_states(active, states);
			if (ret)
				return ret;
		}
	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
		*support = *active = 1;
	return 0;
---------------------------------------------------



在 2021/3/27 上午4:13, Shuah Khan 写道:
> On 3/24/21 4:28 AM, xufuhai wrote:
>> From: xufuhai <xufuhai@kuaishou.com>
>>
>> If the read_msr function is executed by a non-root user, the function
>> returns -1, which means that there is no permission to access /dev/cpu/%d/msr,
>> but cpufreq_has_boost_support should also return -1 immediately, and should not
>> follow the original logic to return 0, which will cause amd The cpupower tool
>> returns the turbo active status as 0.
>>
>> Reproduce procedure:
>>          cpupower frequency-info
>>
> 
> Please run get_maintainer.pl and send patch maintainers
> and others suggested by the tool. I don't see this in my
> Inbox for me to review/accept and send it to pm maintainer.
> 
> Please include before and after the patch when you run
> cpupower frequency-info
> 
> thanks,
> -- Shuah
> 
