Return-Path: <linux-pm+bounces-43806-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAAjE4LFqmnVWwEAu9opvQ
	(envelope-from <linux-pm+bounces-43806-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:16:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C591C2205C5
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B7833084BE5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3738E5EE;
	Fri,  6 Mar 2026 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CI2VRCzS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m15595.qiye.163.com (mail-m15595.qiye.163.com [101.71.155.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC653803FB;
	Fri,  6 Mar 2026 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799062; cv=none; b=OBy3+T795Mm32WH/lNVRi0EXNnBs41+GvZkOzfue/LBYy6sQGzTu03sXF4Hi9QZvyOq4cpkALdkiPq525NrrNv5GfJBK0yqVDazh9uh9+M+99S1D/SDdL+owsacaPOopJMpwMn3ygsCLdsrGhusaXllHKZCjmeMBR7xtkxUNf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799062; c=relaxed/simple;
	bh=SEKGiZVlsj98jr3PYYfvFuNLKbD6t5J7Mp3HHxD0CU0=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZeKHhjwaV326BH99ngcUVgTrc3/6ZOl1MmTsGK7MZM6ZC4FQEnBnW6g9z6hbNbB3W5F88hIcm4wQx2UBw3fzNuqyULUi7pbh4D0IelzPd38uyWu3pbuGXKsTJ1O64vKAqSCmPe16e7OLgej4/3qKsjqxD6ZUexpzCW8U/UQpN+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CI2VRCzS; arc=none smtp.client-ip=101.71.155.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36060f826;
	Fri, 6 Mar 2026 20:10:47 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 0/3] Add shaping support for Rockchip platforms
To: Heiko Stuebner <heiko@sntech.de>
References: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
 <4490342.ejJDZkT8p0@phil>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <4f288c33-7bdc-a0e3-a692-c73646687452@rock-chips.com>
Date: Fri, 6 Mar 2026 20:10:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4490342.ejJDZkT8p0@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cc30eb6bf09cckunm5f657a351437ca6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk9CH1ZCSBhDT0gdTk8aGk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=CI2VRCzStcWKQ9Ad/tb/uF2zXHBwPAPdPFrkOm+knONrKitxrmcKUZp8f0XF4plG4AumREf8NqxUz2PELXzZEY71FVyDiTQQsLQ3YADLwHK9Yp5LmVcrliYHgN27a5PV/DmWiZXe6UMOSgn6XZHUiuXZoPzIEqhlceeU/Nm+rSw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=sGMSAJ+U9DbAoErYPKQSb41tdFBd5OZEpvs8FFtw5wI=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Queue-Id: C591C2205C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43806-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rock-chips.com:dkim,rock-chips.com:mid]
X-Rspamd-Action: no action

在 2026/03/06 星期五 18:43, Heiko Stuebner 写道:
> Hi Shawn,
> 
> Am Freitag, 6. März 2026, 08:40:29 Mitteleuropäische Normalzeit schrieb Shawn Lin:
>> pm_shaping is introduced for some platforms to throttle the outstanding
>> burst requests of each IP to prevent bus monopolization. It should be
>> saved and restored along with the on/off of pmdomain, the same as pm_qos.
>> This patchset adds support for it.
> 
> Can we get some more descriptive naming for the feature please?
> In the commit messages, dt-binding and also node-names in the soc dtsi.
> Because anyone glancing at either the binding or dtsi will not understand
> what this is, and would even need to consult the git history for any
> explanation.
> 
> The full interconnect is not part of the TRM I have, but the bits and
> pieces in other parts of the TRM speak of traffic-shaping.
> 

traffic-shaping looks good to me.

> So for the node I'd go for:
> 	shaping_vepu1: traffic-shaping@27f06088
> 
> and in the binding something like:
> 	rockchip,pm-traffic-shaping = <....>
> 
> I think the whole pm_qos thing is an oversight of the past, because:
> 
> - properties should use dashes "-" not underscores
> - the property name is Rockchip specific, so should likely get a prefix
> 

Yeah, pm_qos is for sure an oversight of the past, I shouldn't would
expect to follow the wrong convention here. Will update v2 later.

Thanks.

> 
> Heiko
> 
> 
> 
> 

