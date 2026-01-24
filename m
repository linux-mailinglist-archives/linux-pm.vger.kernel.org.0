Return-Path: <linux-pm+bounces-41412-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IBmIoo0dWmjCAEAu9opvQ
	(envelope-from <linux-pm+bounces-41412-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 22:07:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3326C7F013
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 22:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6287300E3B6
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478F827F732;
	Sat, 24 Jan 2026 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgeO9DfL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19311CAF;
	Sat, 24 Jan 2026 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769288835; cv=none; b=R0GYXt2QVHbqalzMXjrLtcVlywbpwvGtPdfeEjH7bH13HHXOUopsQwM7HSG4zTY3ZrXZRHz0JUQKjC/nc83iIv87cILYCdOPAVof0KS2G06b30cuActDaKTEQSpUqe5+tTeI635DqNTAIwRtSgO68AEe+IqcUA0jm364WDeKy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769288835; c=relaxed/simple;
	bh=fLYqPxjONg1Zgh+aTVGoH1ZdZkZAy21ct3YQyuc3kTE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dHiFL+36+prDq5L4JmsZY0z6PLrIf3GaBTkx0bLM4JrDg3YFdEEGL8OFPktD3AsnoUDk1+8SRocuOL7h6D4XWNBBKH2kbecnRXLYW3sWGzzQQ4A6aE5TdRlR13xSuMM14NrzxwmB3K0w6exPx+sYU70qI/eHUAnvGjcSffWybLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgeO9DfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DF5C116D0;
	Sat, 24 Jan 2026 21:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769288834;
	bh=fLYqPxjONg1Zgh+aTVGoH1ZdZkZAy21ct3YQyuc3kTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RgeO9DfLHS+6Ptya//YIxeAfyOnvAagz8FWT2WSlYfMofG3IcBLiDQMkCNX0NXrwE
	 xLUKi2dz/ZrIZJ/advG8HPP9kh0KfM4mLFGbxixpfbLr3xVZvUPCq+Xt7Sv6jxIrMZ
	 Hko0WwJRuLzZXfIlmbpmqERHIi2rCzfrA0HeLpYx0+p5CGGY6sp1QjMMBcNdwSpeow
	 Rwh0S3LRcGyEVq9B9mFAItctBsO90eOqOqz+frVcqd64WLNVLCPNKS/sY6o6uOvG4c
	 TmDSRm6mKXpqCgzZkZAv74Uwv2V+JGhhJjOI++taEdAvGjhyB9drpu1Idlquym2HdE
	 6YdHomtG4tYSw==
Date: Sat, 24 Jan 2026 15:07:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 0/4] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Message-ID: <20260124210712.GA180714@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-pci-m2-v6-0-575da9f97239@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41412-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3326C7F013
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:46:50PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series is an initial attempt to support the PCIe M.2 connectors in the
> kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
> Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
> in PCs). On the ACPI platforms, power to these connectors are mostly handled by
> the firmware/BIOS and the kernel never bothered to directly power manage them as
> like other PCIe connectors. But on the devicetree platforms, the kernel needs to
> power manage these connectors with the help of the devicetree description. But
> so far, there is no proper representation of the M.2 connectors in devicetree
> binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
> and fixed regulators in devicetree.

Could you rebase this series on pci/pwrctrl, please?

I'm pretty sure I would mess up the conflict resolutions, and I have
no way to test this.

