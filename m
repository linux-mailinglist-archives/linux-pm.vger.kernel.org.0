Return-Path: <linux-pm+bounces-41414-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANvkCHw4dWloCQEAu9opvQ
	(envelope-from <linux-pm+bounces-41414-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 22:24:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B99807F0AD
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 22:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A17300EA8C
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 21:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4EE27EFF7;
	Sat, 24 Jan 2026 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCr7YfHd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4A10F1;
	Sat, 24 Jan 2026 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769289844; cv=none; b=gGeXgRom2TG9anBs7yuRvPLP+v5qY7LIO+mH8ehgTSddoeeH8TkNvTfUy/V/0IYjW0GOYfcjuTNvDii7TTC4Y6wENVfLUugUS3lzgg3jM9VxD9lg3WK6rBc8Q0U3YtpCIWSH5O4IkG0UYe1JIrQuKS18ab1get7HdyI8Usopob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769289844; c=relaxed/simple;
	bh=AJFo4eAxCnItWVeRCP+XLYGtuLNEENvSrhswbI1WgZw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HsvXhTcPLzYc1JnNKtUk9FDN4IJtdhnBedeFDRsvn1fws2AriVcNIk5ibaFpKP3GRF/AvYrZlM4vJ9e5r+NRbpsV7xFkk7lVu4YuNLwmalPikwfu6+oF8J2xAFf0es+Cl1qXYgsaQELlRVFREvmdhiThrHM6O71REQrz0wp3Tvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCr7YfHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7151DC116D0;
	Sat, 24 Jan 2026 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769289843;
	bh=AJFo4eAxCnItWVeRCP+XLYGtuLNEENvSrhswbI1WgZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uCr7YfHdiPtr0RJAwoaf+mfGXnleR92qoy5sh34I7SD8ghUmrTH5rs3fcpdAXM/Pg
	 RlrVT5qnq//dBIxoDUIy8PNq1G2Pr0XGBPljTsZnBWgUe/tV1R2kcc/s2ie49u+/vR
	 faAkRoRI/uhWjdn+S2pKCnndTU+TP49iO8PamH2VRy4pAuQbAoZEnh8BgYtCUwTzLD
	 FEvVvHK2CobUcpQgsHIpFzFhHQlChoRfEtg5KndfQjJCsWAbnh9FZQTUSwcVL9Us7V
	 RX2Jrya3q3xXLQJB6t9XJ3KKi+bX6VpL8wWM8VVNjCq9aP2mrBjvp8FtKBN4B6gqv8
	 JH/oCMQeU6V/g==
Date: Sat, 24 Jan 2026 15:24:01 -0600
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 2/4] PCI/pwrctrl: Add support for handling PCIe M.2
 connectors
Message-ID: <20260124212401.GA181386@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-pci-m2-v6-2-575da9f97239@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41414-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B99807F0AD
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:46:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Add support for handling the PCIe M.2 connectors as Power Sequencing
> devices. These connectors are exposed as the Power Sequencing devices
> as they often support multiple interfaces like PCIe/SATA, USB/UART to the
> host machine and each interfaces could be driven by different client
> drivers at the same time.

s/each interfaces/each interface/

> This driver handles the PCIe interface of these connectors. It first checks
> for the presence of the graph port in the Root Port node with the help of
> of_graph_is_present() API, if present, it acquires/poweres ON the
> corresponding pwrseq device.

s/API, if/API. If/
s/poweres/powers/

> Once the pwrseq device is powered ON, the driver will skip parsing the Root
> Port/Slot resources and registers with the pwrctrl framework.

s/and registers/and register/

