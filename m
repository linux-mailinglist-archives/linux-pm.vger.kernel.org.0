Return-Path: <linux-pm+bounces-21425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE3A29825
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13D63A4A29
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFB81FC0F4;
	Wed,  5 Feb 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Mp4lri7f"
X-Original-To: linux-pm@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD52193436;
	Wed,  5 Feb 2025 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778045; cv=none; b=Rx2E1kPm1G4vysBGSgjlCimsVxVN8L945HKu4znMTUdLz8NRMGECZdNe0I1XJHGL5jRq2+JWVwMcKFR0x7dMHdop5VpJOAYm3QJY7LeKXH9Bs/1a0yT3UyOKYzwBA6chC/pF042A/T8Vn8zUc04vRWhaETUxSuZRSb1kxEgZEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778045; c=relaxed/simple;
	bh=cvqD5H/oO6J2BVVuC0kSXIdVI2qnFaNf9DIxDmwmUWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVpLx7r3lNavGjMbA4osTisoboDa7fJi3dh6DOPAgnJ4Dgoj6AEiVHv28jWFsSyFVKR6AyEoBKpeGTQ3q1oKfVMHw50JJrXwP3pZUZU3nmx7NFuVuTYK98coLBIIi9g63NyXddZ79UGxMF8FrV6FqJHVhDd/ubHDqpc4UHlVmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Mp4lri7f; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Yp7CG5tzYzlgTwJ;
	Wed,  5 Feb 2025 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1738778037; x=1741370038; bh=cvqD5H/oO6J2BVVuC0kSXIdV
	I2qnFaNf9DIxDmwmUWg=; b=Mp4lri7fHOytWVQrYW9s6kNbMSOIaibGsEHPTwNC
	8LTJbv6ehm45Z3XT596lPYjSUVP7lOfKmqPJ38uI21NualYOzUhSiZePGTw3rCAC
	IbtRcTg+lig8/19PY+4RNkUcXQW92+OYel5Y0vUfNEUVJVQpQEsXhpMOpl/KwMrX
	G2QZi0TbOOlwcLwcENsRdjviFUm5K4YWehj7bKvptoJPyLTsOlalbi3g+Zxgfdfu
	kCFfFf0XhzPc1mPI+cdvsfPwFkgk8wQGbDLkRqkjzev93I1cIEyc8FRq2SJgm89S
	Ze3A39oywbXkJQgpzAB/viCQd1LEevCYYJxeebU4KoDvsg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VIrMFUaWq9nU; Wed,  5 Feb 2025 17:53:57 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Yp7C210jVzlgTw2;
	Wed,  5 Feb 2025 17:53:49 +0000 (UTC)
Message-ID: <30a766f7-66a1-4ee4-b829-00544ba10824@acm.org>
Date: Wed, 5 Feb 2025 09:53:47 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] scsi: ufs: core: Export ufshcd_dme_reset() and
 ufshcd_dme_enable()
To: Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
 linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <1738736156-119203-6-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1738736156-119203-6-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/4/25 10:15 PM, Shawn Lin wrote:
> These two APIs will be used by glue driver if they need a different
> HCE process.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

