Return-Path: <linux-pm+bounces-43069-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJdvFuuwnGmYJwQAu9opvQ
	(envelope-from <linux-pm+bounces-43069-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 20:56:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C689117C939
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 20:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C75B30488E7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 19:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9943E374752;
	Mon, 23 Feb 2026 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7mg8C26"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514B165F16;
	Mon, 23 Feb 2026 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876584; cv=none; b=CvfIZf5rmxfefk0sT5wTaulyf6XpMi2252K285B65RYLo8/Xxq0I+1Xw7GX0S52m8eL5Uu3AxACpobFSLktaUgQOfTJfAdfzXkW86WFO/Ic3d6QIM45t6QAIbm5PGF8Mjhaz6y8MkKeNNo9nJwE7+jCh+BR/MXWhaUx+mtKyIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876584; c=relaxed/simple;
	bh=fUdTKyGY0sCgBkhNIkCLCe+hZ2qWhwjcWgdiva+w5eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOkA/ZPhv6X/0vk8a6wU34MUGNTMZOXlZKOWiv5yZe2FPouzAYiLxLPXQKqqNjpGKfAQgmerImujx0Ox65bx3DXKWQiaf+1BfTPBxYUwcmphrM6YZpwj8Y/dsuFqF4GoihXkaT33YiJ9AmwC85gFfrPvglDvKtFXCQ7aV4DLy5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7mg8C26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D615EC116D0;
	Mon, 23 Feb 2026 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771876584;
	bh=fUdTKyGY0sCgBkhNIkCLCe+hZ2qWhwjcWgdiva+w5eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7mg8C26QqGX9PJTYG7QFHrx7ajIu10k4NsgNNxPIzJuj/BqKkABUGSDWsu3F32CL
	 Xu24wOlsZOccm61v1igfTiUZYDsAx+1lRzFe+MlqMI/Sb0EdUPF4WPfL50h9OP5qWj
	 nkCuqmUy/kFzT6Mvydsdi6DtVQ8Y+crHzn+Bnv8bSwziwq3Ykxi0Uq2DTqWIN6ttmO
	 YaPR12hNzhZS+e82qQJPNck3ABEDqISGhx6ohgMHlIBLU/S9cNrEUFWkIlLUzPXhRO
	 86iyUa4rogkyvteFdOwCfO0maNqnd/SVQ7V/4IBBYWvSFm3MBfNvQF6OK3UIMV+dT+
	 Woj5Ltdwwvh2g==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	sre@kernel.org,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/5] soc: qcom: pmic_glink: Add support for battery management running on SOCCP
Date: Mon, 23 Feb 2026 13:56:06 -0600
Message-ID: <177187657318.166046.16981095492238346823.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43069-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C689117C939
X-Rspamd-Action: no action


On Mon, 09 Feb 2026 12:49:10 -0800, Anjelique Melendez wrote:
> System On Chip Control Processor (SOCCP) is a subsystem that can have
> battery management firmware running on it to support Type-C/PD and
> battery charging. Add support for devices, such as Kaanpali and Glymur,
> which are running battery management on SOCCP.
> 
> Changes since v4:
>   - Defined Glymur and Kaanapali compatible strings as "base" compatibles
>   - Split v4 p4/4 into 2 separate patches (v5 p2/5 and v5 p3/5)
>   - Added Glymur and Kaanapali compatible strings for pmic_glink auxiliary
>     drivers
>   - Link: https://lore.kernel.org/all/20260114211759.2740309-1-anjelique.melendez@oss.qualcomm.com/
> Changes since v3:
>   - Added "dt-bindings: soc: qcom: qcom,pmic-glink: Update X1E80100 compatible string"
>     and "usb: typec: ucsi: ucsi_glink: Add support for X1E80100" to series
>   - Corrected bindings dependencies
>   - Renamed pmic_glink_data structs
>   - Link: https://lore.kernel.org/all/20251217055655.638594-1-anjelique.melendez@oss.qualcomm.com/
> Changes since v2:
>   - Updated bindings dependencies
>   - Removed qcom,glymur-pmic-glink compatible string from pmic_glink driver list
>   - Link: https://lore.kernel.org/all/20251027212250.3847537-1-anjelique.melendez@oss.qualcomm.com/
> Changes since V1:
>   - Corrected bindings dependencies
>   - Renamed pmic_glink_data variables
>   - Dropped "soc: qcom: pmic_glink: Add support for SOCCP remoteproc channels"
>     since it was applied from its original series:
>     https://lore.kernel.org/all/176157405464.8818.5887965202916918883.b4-ty@kernel.org/
>   - Link: https://lore.kernel.org/all/20251017003033.268567-1-anjelique.melendez@oss.qualcomm.com/
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: soc: qcom: qcom,pmic-glink: Add Glymur and Kaanapali compatibles
      commit: aed7440146548cbbcb36780ccc6f9db4cf18f832
[2/5] soc: qcom: pmic_glink: Add charger PDR service information to client data
      commit: 540262793df13d90274aae90aa70584ef6fb3aa4
[3/5] soc: qcom: pmic_glink: Add support for Glymur and Kaanapali
      commit: 9386d9e8cc72edc1a55ee1337c442b3ceff1d1ba

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

