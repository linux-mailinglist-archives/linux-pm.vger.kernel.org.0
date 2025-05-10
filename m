Return-Path: <linux-pm+bounces-26979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01072AB213C
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 07:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBAA9E0881
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 05:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AB61AA1FF;
	Sat, 10 May 2025 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YBEY9j+X"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8217BEBF;
	Sat, 10 May 2025 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746853683; cv=none; b=CkalDFM0nabJo2tTOoH6sIJKZyBXpH21fSkSrC+5M6jCqr51TdXWYrmUcdpY1QZu3nwvAh3UDZOsnoseVXbUn+PhSBkyziRCGZljNuWkqvpfheIAEF4IpTN2MdnsVfvvISWkyxmLeIKP8FlqmGW1DtT/F1e3y/exws1f8aFhA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746853683; c=relaxed/simple;
	bh=2h/ER4Av5lrZ2ZNbEqOS7iazNxZZsmjP5bUvBqvZhUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZQxMybTuqXv1UKFYc6zLYeeXTc+x3MeSOLSrf1BhZi8pYeyZwsbRS7ykjSr2IfTVktacp13oCtvaUpQsDKnpKweDR2WfTV+uErpFVRjHhyruY7FhgYfTUGds8ALoNJ48WlxSBobUNpUM0MnO1hsThpnBjGvxzauoZtnBk8JdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YBEY9j+X; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UGMVV710k7xJlFKtjlVNBynWLBl3NNPuBRG70mWr2do=; b=YBEY9j+XC4IC45jPI1bm9e4Ser
	n2tV19cBysctuRt1INGgt0OOzW0z1iPPLqrFvEnfxiNWiyQ8gra6aFkID4e0I5waSa3M1l4vSlLGd
	CCQttpYTCDTjr759BPcpctqDRjn6lF4PqI1HX/ikdR3K8MdCS7uIoJKoCxYxxloGJJgvjJAWqtZu4
	EdbOfUa8jMnzgZAHUmOrarw4rr+yCnICLUrdYCZK856GKipwaZ/q/ollK2SPPvLS+CXxf0CXvcxCu
	lxXArU4Wd4+i7MfsHodYUHI8g+oSa7Lna81+CmSSFZHhhAnb7WKaelgL6lYXXpfrNAZl7Lgu6utyg
	cF0GsvYw==;
Received: from [106.101.9.89] (helo=[192.168.6.21])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uDcMc-0064se-DT; Sat, 10 May 2025 07:07:53 +0200
Message-ID: <90834b07-9261-4be6-a10b-88d3f5308e1e@igalia.com>
Date: Sat, 10 May 2025 14:07:45 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Add inotify support when the energy model is
 updated.
To: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 kernel-dev@igalia.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, len.brown@intel.com
References: <20250507014728.6094-1-changwoo@igalia.com>
 <a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com>
 <CAJZ5v0ixh=ra-TDbC59rpZoGn0pRWmAMchHqoOb_XwB2XUzA7Q@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAJZ5v0ixh=ra-TDbC59rpZoGn0pRWmAMchHqoOb_XwB2XUzA7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you, Rafael, for the pointer.

On 5/10/25 01:41, Rafael J. Wysocki wrote:
>>
>> I have discussed that with Rafael and we have similar view.
>> The EM debugfs is not the right interface for this purpose.
>>
>> A better design and mechanism for your purpose would be the netlink
>> notification. It is present in the kernel in thermal framework
>> and e.g. is used by Intel HFI
>> - drivers/thermal/intel/intel_hfi.c
>> - drivers/thermal/thermal_netlink.c
>> It's able to send to the user space the information from FW about
>> the CPUs' efficiency changes, which is similar to this EM modification.
> 
> In addition, after this patch
> 
> https://lore.kernel.org/linux-pm/3637203.iIbC2pHGDl@rjwysocki.net/
> 
> which is about to get into linux-next, em_dev_update_perf_domain()
> will not be the only place where the Energy Model can be updated.

I am curious about whether the energy mode is likely to be updated more
often with this change. How often the energy model is likely to be
updated is the factor to be considered for the interface and the model
to post-processing the eneergy model (in the BPF schedulers).

Regards,
Changwoo Min

> 
> Thanks!
> _______________________________________________
> Kernel-dev mailing list -- kernel-dev@igalia.com
> To unsubscribe send an email to kernel-dev-leave@igalia.com


