Return-Path: <linux-pm+bounces-43670-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL6SDtVVqWng5gAAu9opvQ
	(envelope-from <linux-pm+bounces-43670-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:07:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB7220F60A
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DDE83010B42
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922DA37BE77;
	Thu,  5 Mar 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrk1MOcb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7E375F62
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705124; cv=none; b=QjpniLbju05jebPDCtPiXmgY9qHdiU8i/uWMjEhVaMFb8Vr20O2nZ7Yx8vcaplfD1XA0pJHaxV7w6E1H/1ppBzxZEK6QIctGy2ayf2qhRu39YnvbuZ6FmD/SMRLkAV/lIEaiS+pymukVD1jd4A5TKzzUBh5Ur1dtoNLQGtvDalA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705124; c=relaxed/simple;
	bh=lQ0T9bUE9C/9y8Vs6pywRcQ3tiB0ev9f4VxMdnV+hAk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar40oasfXA+WChFV41r2dg/I3HCbmK11OiplqRmFlf5CThE0AvpybztMdpB7EXet+tm8fRztqBH1a/IDEvODAqAUTUIWvsBQbs5BSiLHSl+1tbnX8DPJjtdZebQOlXWv932lo0IH1tU3X6MaSm25pWPIpuqSYsHP+7IqFkohvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrk1MOcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F8EC19423
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 10:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772705124;
	bh=lQ0T9bUE9C/9y8Vs6pywRcQ3tiB0ev9f4VxMdnV+hAk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Rrk1MOcbJC7diGpkgHuAM97vXMc8P/tAN1MFcvPsz7M8WIioAvB9XmrQqu5l+dSOg
	 aqOzcPXh6wSPUm4OVtyZxFCi+cRg9dF2mhjO7HfmL6gRHmrm4l6E+qtIfIiBx3RM8d
	 dkaAfVCb4KCX0Q53zYLrv8P7wUElGWhYZn9npg6tk4bytkPMfj/oDiiZoqr9PVQNyZ
	 XrwRcUKB0ctZvgOj+MPTqa6r76dEWwCKo97NqFJlBdWXE4eLOzRIGpzVIrspHKuzwN
	 +UsuV5+xp7XgdQWqMORe8SoS+IHXb9l30Aw1JZGDBSl0dJkLjmhcnKw+1mfgfnpvhQ
	 y7sT9ETdlhkPQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a2a59baa6so20323001fa.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 02:05:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMedbV/D3MQDYtfvLJ22fAktWlpz6hRawq1oF5dFtIXE+5LHSUPV9uuYt4QjnteslHG6JqpaxIHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqkcqIUvoDf+gPnc2KHGsrWzEcOMYmDJRefQor0AauQ7D9Ds2Q
	Aoi0KTMZIy9aoLvdp98rk1ARv/zHRULPIjLGKcbbBA9CvD/88dkYgfyuZ19mMg213+YyKKiDzlF
	wxGHtFSneD/bUp36nFH04Q016p3XiqHviuSd78FB4/g==
X-Received: by 2002:a05:651c:41d6:b0:387:4ee2:1cbe with SMTP id
 38308e7fff4ca-38a2c564d92mr31840641fa.2.1772705122833; Thu, 05 Mar 2026
 02:05:22 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 05:05:20 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 05:05:20 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260304-arm-psci-system_reset2-vendor-reboots-v20-1-cf7d346b8372@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
 <20260304-arm-psci-system_reset2-vendor-reboots-v20-1-cf7d346b8372@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 05:05:20 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mdnf_F2JtSOaz4AkZT6EErYhMcVT8HZ+bf_zO+FCH+OUA@mail.gmail.com>
X-Gm-Features: AaiRm52_Ghl_cyrpx4-PLseenakv1wMTEmeY_ZbSCiMyp4qVQG4KYHqTiXWk5K0
Message-ID: <CAMRc=Mdnf_F2JtSOaz4AkZT6EErYhMcVT8HZ+bf_zO+FCH+OUA@mail.gmail.com>
Subject: Re: [PATCH v20 01/10] power: reset: reboot-mode: Remove devres based allocations
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, John Stultz <john.stultz@linaro.org>, 
	Moritz Fischer <moritz.fischer@ettus.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Sudeep Holla <sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CFB7220F60A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43670-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,oss.qualcomm.com,linaro.org,vger.kernel.org,lists.infradead.org,arndb.de,arm.com,rock-chips.com,gmail.com,ettus.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,mail.gmail.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 19:03:01 +0100, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> Devres APIs are intended for use in drivers, where the managed lifetime
> of resources is tied directly to the driver attach/detach cycle. In
> shared subsystem code, there is no guarantee that the subsystem
> functions will only be called after a driver has been attached, nor that
> they will not be referenced after the managed resources have been
> released during driver detach.
>
> To ensure correct lifetime handling, avoid using devres-based
> allocations in the reboot-mode and explicitly handle allocation and
> cleanup of resources.
>
> Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

