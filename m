Return-Path: <linux-pm+bounces-41479-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDY7CwJvd2m8gAEAu9opvQ
	(envelope-from <linux-pm+bounces-41479-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 14:41:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BDE8900C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 14:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6AD4302826F
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B16333A9D6;
	Mon, 26 Jan 2026 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnFN7xxC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54F329E5C;
	Mon, 26 Jan 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434711; cv=none; b=BVRSG5p9YHcibfjLrhJFAZke1fUaPSHvrZo3d1jee7CzqxIw2ZYaub4DOH2yeRC9KSWC2pU70E6rOei0uNKjpkoI5PwtYOaOtG0MCO+EQyBf+EBWvGdVckEpDORitIy/e68H1OeUoQRHIHUXQBXTLEcUncZ/4J39Zjr/TnQ8G+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434711; c=relaxed/simple;
	bh=Be0TIhWmqT/RZLmooeWWhCuzdKF5DM1tcofGzKCBFLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQQN060r2iccGRAxvpMvGfLrn5QEMu08+AUeurj9+u7mlzc+Xu9azCxMpoIU+6OjqwBBGz6NNrIRzfCt6iwnZFaYo8n3seN/6WbqF/3iUroKMINS4OjuKuOc1em/NtmLYoicRmbIXAbR4j30bvvUEfXoX9gPcPNJwwJfq80KkYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnFN7xxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D44C116C6;
	Mon, 26 Jan 2026 13:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769434711;
	bh=Be0TIhWmqT/RZLmooeWWhCuzdKF5DM1tcofGzKCBFLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnFN7xxCUGHYU/3+sQaxZ9Nl3FzCPpEacGee/Z6HBDRkroJODWb7uaEcptZMhQ6AE
	 pAMyjm2CTMeLLPSDVFaXEvUHuvEJiTYYIzyedJOZeIV2VAfRJZ0P15m1J8rHRrrBHj
	 AyYiGe5DEeZFcycx3EOoTwiWmII1Uq1Fz+ZfLTGCCeKbUMAhWz9YP1Y8EavfUBATmZ
	 p7EXqVmT7uAmD73tZ9fqdD3r+YPd8cVFfd7S5w/DX1NwaIfO5/CVRKZuG6Pm7pWaaT
	 WyE+7UmX0rRkIG1zzTRn/UztujhOvq7u3OTAy3q2cKwTUGw33FUJXhN683OKulf41R
	 eaksh+D7eMdEA==
Date: Mon, 26 Jan 2026 14:38:22 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Andre Draszik <andre.draszik@linaro.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>,
	Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>,
	Song Xue <quic_songxue@quicinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: [PATCH v19 00/10] Implement PSCI reboot mode driver for PSCI
 resets
Message-ID: <aXduTklGm6AOeaGG@lpieralisi>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <2dcd9e3a-0a40-0dfb-29b8-99b70b73a59a@oss.qualcomm.com>
 <9e9b9faf-7c5d-2e83-a8ac-37afeffd81d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e9b9faf-7c5d-2e83-a8ac-37afeffd81d4@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41479-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,oss.qualcomm.com,linaro.org,vger.kernel.org,lists.infradead.org,quicinc.com,arndb.de,arm.com,rock-chips.com,gmail.com,ettus.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lpieralisi@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7BDE8900C
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 04:08:11PM +0530, Shivendra Pratap wrote:
> 
> 
> On 1/6/2026 4:38 PM, Shivendra Pratap wrote:
> > 
> > 
> > On 12/28/2025 10:50 PM, Shivendra Pratap wrote:
> >> Userspace should be able to initiate device reboots using the various
> >> PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
> >> patch series introduces psci-reboot-mode driver that registers with
> >> reboot-mode framework to provide this functionality.
> >>
> >> The PSCI system reset calls takes two arguments: reset_type and cookie.
> >> It defines predefined reset types, such as warm and cold reset, and
> >> vendor-specific reset types which are SoC vendor specific. To support
> >> these requirements, the reboot-mode framework is enhanced in two key
> >> ways:
> >> 1. 64-bit magic support: Extend reboot-mode to handle two 32-bit
> >> arguments (reset_type and cookie) by encoding them into a single 64-bit
> >> magic value.
> >> 2. Predefined modes: Add support for predefined reboot modes in the
> >> framework.
> >>
> >> With these enhancements, the patch series enables:
> >>  - Warm reset and cold reset as predefined reboot modes.
> >>  - Vendor-specific resets exposed as tunables, configurable via the
> >>    SoC-specific device tree.
> >>
> >> Together, these changes allow userspace to trigger all above PSCI resets
> >> from userspace.
> >>
> > 
> > Hi Lorenzo,
> > 
> > Is this patch series now converging towards the design changes you
> > proposed in v17? We’d like to conclude the design so we can move it
> > towards closure.
> 
> Hi Lorenzo,
> 
> Can you please review if the design aligns with your proposed changes?

I will try to do it this week.

Thanks,
Lorenzo

