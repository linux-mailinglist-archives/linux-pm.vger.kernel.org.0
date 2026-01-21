Return-Path: <linux-pm+bounces-41252-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGFJLoQ4cWnKfQAAu9opvQ
	(envelope-from <linux-pm+bounces-41252-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 21:35:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C65D57A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 21:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9542E4ACA47
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 19:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC63E9F6F;
	Wed, 21 Jan 2026 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH/NT0H2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A033E95B7;
	Wed, 21 Jan 2026 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025381; cv=none; b=OHnZMF5D6nHdh0p2AF+D4bC0whLQ2zNgn4caSfyDMwC17s83lQERQ+9UQlbtjvrCuuf90l644aFUtPlVau/AIma+6+iPAo8fEz3nU5+ihraKUX1+ACDSMChtRMH0gC3mwbmN6BMu1VgfcuToJ45AVhkB+gbLqLy2F8KRvO3ym48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025381; c=relaxed/simple;
	bh=QudhuLjt/ftZ47KHyR6bOUgFxJZlRqt+cOPaBtwNzag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNv/TY3/I6GI5boRFbQG4ljlwlUMvh9R707YWTDpigh/9gvcF7Svatqh5hQlFDCWLHeKMFhiqd6apxxo8FUqiDQ1F6Juj2E1vnjAl2IIZLTdyAT9x2/bOpm43OOZxcIBF1VlCD+zcXy7J1Vnd8YwPC+PaL2dXUJWBdN4wig/SG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH/NT0H2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37BCC4CEF1;
	Wed, 21 Jan 2026 19:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025380;
	bh=QudhuLjt/ftZ47KHyR6bOUgFxJZlRqt+cOPaBtwNzag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VH/NT0H2X4JjVIHykv1keC6UCuWG11/CnLSn2Egj9sfFiAqRBLQ8xmFHEouAtLGNT
	 QraK2bKHhK0f9b80Pl3PickGJ4AE1I4y6CPtNBHpYT7RByG3aPiAD1ICEl5gAPCErn
	 /ba0sAyO5rbgHEC9NBYGaXnygOv/B/L4oeMqovce/qrNT12QgEJhgIMn3sTA2qvPav
	 6KX9SHNmu0BrdMccvh5f2hEoHiveZnQ3rDjd5klLHanPULL8P+RzvsIC42w9pY6XEc
	 AH041iED2jlG6UaLfaPRixue6B3Kx1mS7NakibcawoA28dSqLqrZYyqFG6KQxOPSg0
	 K1DFdbToApK6g==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: (subset) [PATCH v2 0/5] Enable QoS configuration for SM6350
Date: Wed, 21 Jan 2026 13:56:08 -0600
Message-ID: <176902536618.1171053.683560671228567774.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251114-sm6350-icc-qos-v2-0-6af348cb9c69@fairphone.com>
References: <20251114-sm6350-icc-qos-v2-0-6af348cb9c69@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41252-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A00C65D57A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 14 Nov 2025 10:31:08 +0100, Luca Weiss wrote:
> Update dt-bindings, driver and dts in order to configure the QoS
> registers for the various SM6350 interconnects.
> 
> 

Applied, thanks!

[5/5] arm64: dts: qcom: sm6350: Add clocks for aggre1 & aggre2 NoC
      commit: 15bbdb3e56684bfe6ca2a38dd9c2d5bd2d2a8247

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

