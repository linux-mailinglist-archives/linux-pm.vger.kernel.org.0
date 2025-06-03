Return-Path: <linux-pm+bounces-27987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EB9ACBFFA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 08:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B44817289B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 06:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3BE14A0B7;
	Tue,  3 Jun 2025 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="m6YHCxbC"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973438494;
	Tue,  3 Jun 2025 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748930527; cv=none; b=iG6TxKiS449aNMsV65vg5F4UEqV3PQ93S9jufj9yyf1kXKpTzy+DdnJulcySbDaeiYYZ3lUIWKliVA74Isew5Yho3/mtP/D2bCx0W1xeDfvfjGijkeVT+FfQ0pNguWjug7iQ9SqxfKYrVLFB1goXPnuFIpwxtFaX7PrrXtMBCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748930527; c=relaxed/simple;
	bh=5Fg+3ynTLDNZ7r/CjS+aXA53C0xkliXz/Kk3S6GgcAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbI9HGTv5blRdEX2p2DTtzbjulXcCx21Z9tPMOkIe0xt0F0P5VgbYD049smXmQjG6rlqpqMDJZEGm+8Gfu9eWbDToBMSdYUKTZufwJU6Kqt18yM83ldU0iBCmyVTMjH7auePyjHvOwhASbZ1P756EtjLIvOqz0ObWoky/zOYUNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=m6YHCxbC; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H0mSjLSUUlxN+gOU+AZ84fBGYKTcQw03ke0u1pwk2wg=; b=m6YHCxbCYT6qPI9mMsYrkZLcDQ
	UOGH5ndMMkB9ouAFpZDfVMLsVzl2kUgMuNSN2uKtURIXkz1XjH3aoBF8qu1iAQVKs2uMKqVQCbYuh
	+5wO2oU8t0+OvyIHR9VlpHCHc9rgt703AP5scMRFExTPPbGsLt5YiigMMEGANu6N0mraaMQ+9+4UE
	Ew5tkLtHz+oNPQCbqoOIOA7cC675qttIOQBarrTZu/8T0TjPmKAAehEFKUrswXQOWeFcpeyS0s7o9
	KNqr6f/qskxIdbb15jcDVWyhIIbFpi5HwW44cDtCCjk5n+XUFIW6IkUwokdtM/UQE2ednGAsilTXT
	9sSWhY9A==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uMKiZ-00GY5E-UM; Tue, 03 Jun 2025 08:01:48 +0200
Message-ID: <4263e586-f1ea-4797-8789-116d173058d9@igalia.com>
Date: Tue, 3 Jun 2025 15:01:38 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] PM: EM: Add a skeleton code for netlink
 notification.
To: Lukas Wunner <lukas@wunner.de>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com,
 pavel@kernel.org, christian.loehle@arm.com, tj@kernel.org,
 kernel-dev@igalia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250529001315.233492-1-changwoo@igalia.com>
 <20250529001315.233492-3-changwoo@igalia.com> <aD4BOga3GvPewnqI@wunner.de>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <aD4BOga3GvPewnqI@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lukas,

Thank you for the comments!

On 6/3/25 04:53, Lukas Wunner wrote:
>> diff --git a/include/uapi/linux/energy_model.h b/include/uapi/linux/energy_model.h
>> new file mode 100644
>> index 000000000000..42a19e614c7d
>> --- /dev/null
>> +++ b/include/uapi/linux/energy_model.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +#ifndef _UAPI_LINUX_ENERGY_MODEL_H
>> +#define _UAPI_LINUX_ENERGY_MODEL_H
>> +
> 
> It looks like you created the header file manually.

Right, I followed the structure and design of thermal_netlink.{ch}.

>                                                     There is tooling
> to auto-generate all the boilerplate code from a YAML description in
> Documentation/netlink/specs/ and my (limited) understanding is that
> using it is mandatory for all newly introduced Netlink protocols.

Thank you for the suggestion! Using YNL will definitely be easier
to maintain in the long run. I will work on defining the YNL and
generating the boilerplate code using YNL. It will require some
reorg of files to keep the autogenerated files intact.

Besides the boilerplate generation, what do you think about the
current commands and events defined? Does it look reasonable? If
you have any feedback, I will incorporate it in the next version.

> 
> I just had to wrap my head around all that for SPDM (a device
> authentication protocol), see the top-most commit on this branch,
> which is in a WIP state though:
> 
> https://github.com/l1k/linux/commits/doe
> 
> Basically you create the uapi and kernel header files plus kernel source
> like this:
> 
> tools/net/ynl/pyynl/ynl_gen_c.py --spec Documentation/netlink/specs/em.yaml \
>    --mode uapi --header
> tools/net/ynl/pyynl/ynl_gen_c.py --spec Documentation/netlink/specs/em.yaml \
>    --mode kernel --header
> tools/net/ynl/pyynl/ynl_gen_c.py --spec Documentation/netlink/specs/em.yaml \
>    --mode kernel --source
> 
> And then you add both the YAML file as well as the generated files to
> the commit.  The reason you have to do that is because Python is
> optional for building the kernel per Documentation/process/changes.rst,
> so the files cannot be generated at compile time.  It is possible though
> to regenerate them with tools/net/ynl/ynl-regen.sh whenever the YAML file
> is changed.
> 
> The tooling is somewhat brittle, see 396786af1cea.  In theory ynl_gen_c.py
> is capable of auto-generating code for user space applications as well
> but it crashed when parsing my YAML file.  So there are more bugs,
> just haven't had the time yet to fix them.
> 
> 
>> +int __init em_netlink_init(void)
>> +{
>> +	return genl_register_family(&em_genl_family);
>> +}
>> +
>> +void __init em_netlink_exit(void)
>> +{
>> +	genl_unregister_family(&em_genl_family);
>> +}
>> +
> 
> It looks like em_netlink_exit() isn't invoked anywhere, so why define
> it in the first place?  You only need this if the feature can be modular
> (which it cannot - it's gated by a bool Kconfig option).  Then you'd
> call em_netlink_exit() in module_exit().

You are right. I will drop em_netlink_exit().

> 
> Also, you may want to consider moving this to patch [03/11], where
> em_netlink_init() is actually invoked.  And you may want to move the
> postcore_initcall() to this file so that you can declare em_netlink_init()
> static, don't need em_init() and don't need the empty inline stubs.

Thanks for the suggestion. That's simpler. I will change it as suggested.

Regards,
Changwoo Min

