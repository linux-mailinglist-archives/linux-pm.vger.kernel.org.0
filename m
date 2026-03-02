Return-Path: <linux-pm+bounces-43467-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGJRNU0gpmlQKwAAu9opvQ
	(envelope-from <linux-pm+bounces-43467-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:42:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 986291E6C23
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FE0D303321F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A67E33F5A8;
	Mon,  2 Mar 2026 23:42:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A3133EAE6;
	Mon,  2 Mar 2026 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494920; cv=none; b=ixk33t/qLXbSJU6+zdWlAzDRqOPtb7x06A54zv8S9TOYP7cQsfYlDIgpoxTyCaF3K7TFxJ4BGV5qsq0aRjIRL0u8rnzaGLDhmPdtZvoT9/m0AqzMrQJQKy4yVoxnRBJGRRVZuEls3jeaQI8oJnnvReuOhjUJk5ZgpNhGPJwOELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494920; c=relaxed/simple;
	bh=Ibo6q6J6wq9fOgEmwGoItS/j8Y9Vsc5d5uUEb5j+FR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ff6p3XZL/oQbvoRAMqmC+GZ6saaj3hKR4YyuHPObtOTu3z9c3f1xbrZdQJ1tKie6i7BsIZdXldbSeKjS2yYKFan6XJVVkbU0rXecGFG/CajSV1CnvPHlJ88dRbclZijWIXwORydUNqFkHk4X9Vvv5vEcQrkYRYSqRHp/BH2Ft6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA6AC2BC9E;
	Mon,  2 Mar 2026 23:42:00 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 40B7918125A; Tue, 03 Mar 2026 00:41:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org, 
 heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-usb@vger.kernel.org
In-Reply-To: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/5] soc: qcom: pmic_glink: Add support for
 battery management running on SOCCP
Message-Id: <177249491825.606802.14539050804408850588.b4-ty@collabora.com>
Date: Tue, 03 Mar 2026 00:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 986291E6C23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43467-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,collabora.com:mid,collabora.com:email]
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

[5/5] power: supply: qcom_battmgr: Add support for Glymur and Kaanapali
      commit: 1590225fca255d2380c0888608719012fd283436

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


