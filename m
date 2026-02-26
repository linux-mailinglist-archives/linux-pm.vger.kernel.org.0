Return-Path: <linux-pm+bounces-43228-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I8qDEwvgn2lbegQAu9opvQ
	(envelope-from <linux-pm+bounces-43228-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 06:54:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CAB1A1210
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 06:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D0D130A0532
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 05:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C4E38B7AA;
	Thu, 26 Feb 2026 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWc4lbSO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC12C11F8
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772085201; cv=none; b=e9vck4xMEBhTQ6wCmGZwFRPd1ah6u6PkpSj3danqVX2z608pVwoh2gJouM7ZhT5xXX6Bc+Hk0+9On0FemjOApw4/deQ86MxFW5pI29BmTJTn17fEr4LgN8RQLHi8Ke34sTlJAHLTmmAF7cwZtlyn1+uuigBw4yFjGD65LIJ8gh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772085201; c=relaxed/simple;
	bh=Qlw/1Ju44GL9aQDN0N2cEiRZFdixh9GCnMHZ/Mti0+w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WNNZnY8I+j0dfNFLroBc0sMd0K1s4exxqh1nTy4ch2IWuHAVuwyx68MMjsg3K5Y+jmczYe3wkMNw2I6l9Vb5gdr+36v7TaZ2DeM7YadnxqHsC3ni7SX+E6Vp/Q5mVHiJ81dQpLLyz5nwR0nbEGyd5TWdmZylBMOmSUJJafrwY+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWc4lbSO; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1277896014fso11891055c88.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 21:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772085197; x=1772689997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6fqgL7f/DJ61Hn3+dq/y0RfyIFeDJLaKoFUILGJGRcs=;
        b=tWc4lbSOQ9rCulMXUSwQcNt2tJKbaeou+cWG7CJ86s/xD/CBIdQZCP2TQbwTMouHll
         GDrYhLXZqZu0O8Jlxy5ZGiLdpB3bzMIFJ3uOLxlu3Fx66bECK3Xdzuda3mziuLeEhoXj
         JbWhA5R6no6g0hOZ5pXkxxLBcyr4Zsa6lIhW5iOstscUVIUAvvgTMZ2FshHEPHONQjux
         e7IlZPXHWjQMiXyak+DbJ2gXrZLxM1EZ+OqevwbleUC8GAgertiK0j+5+SqINQ8ND2g1
         WZAb7JeMhJkgJBTsnB68yYYjPjurJAo91LM4o/GFt97VD6l03hCMp5g9sX76LN6GX4Xs
         ocyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772085197; x=1772689997;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fqgL7f/DJ61Hn3+dq/y0RfyIFeDJLaKoFUILGJGRcs=;
        b=m/Ijyphvy1BbF2qd6CKk55vw/WyUpFpxBtFqaTs9Qbhxmj+NlWDKfplS0maaCwe794
         vvWi/8RxBbliljjgWerPlD4vhmZyJ8mRkD9blwweFdWg4r2Hq8065Z6oQIog/8X92U+y
         JboL6kB0FuXDmSivw5+QbYmiy0uNCeZrEJ0QPVpGyiSBTEOTQir04cjq0TwjjD9CXloO
         RZx9aUCyskXecq/G4pV4cQyOwHWTofomIno/ypdTALId90mBS5/dGSZT9T29LENxrBnJ
         B6z41yt2LfnvYQQlArFlwqfaq4EJfsJ3SuSWKGNmjCcrod/VCXsUdMOVQWzeodd+8buk
         oohw==
X-Forwarded-Encrypted: i=1; AJvYcCWJoCj0RC3Ii7jj3nJmAzkA7ifkRCvq+gPH/9VJRX5O/J8ZQSB7iqGIOiSOr/oOfnX2LSyo43I4ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvymorHKXNVz6CEngBtmLQ8zx/NDwaQn/nBNd0GlO64tWPE3D
	XMf8YzQYKjVc7+Qy2oP9r3iALf2RiBUpoydz/qGhF6fJ3kLf5iaheDJtskCYnCZSIo/LNSPF6ph
	wJcNndA==
X-Received: from dlbbz39.prod.google.com ([2002:a05:7022:23a7:b0:127:c11:f47a])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:670d:b0:119:e569:fbb2
 with SMTP id a92af1059eb24-1276ad77ce7mr9417450c88.33.1772085196605; Wed, 25
 Feb 2026 21:53:16 -0800 (PST)
Date: Thu, 26 Feb 2026 05:53:08 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226055311.2591357-1-badhri@google.com>
Subject: [PATCH v1 0/3] Add support for AVS in TCPM
From: Badhri Jagan Sridharan <badhri@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Sunil Dhamne <amitsd@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43228-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[badhri@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.966];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1CAB1A1210
X-Rspamd-Action: no action

To facilitate optimum charging USB_PD_R3_2 introduced a SPR AVS
(Standard Power Range Adjustable Voltage Supply) which is a power supply
mode operating within the Standard Power Range (up to 100W). It allows a
Source to offer an output voltage that can be adjusted by the Sink in
fine increments (100mV) within a defined range.

Unlike the Programmable Power Supply (PPS), SPR AVS does not support a
programmable current limit (Current Limit Mode). Instead, it functions
similarly to a Fixed Supply where the voltage is adjustable; the Sink
is responsible for ensuring it does not draw more current than negotiated.

This patch series enables sink to enable and negotiate SPR AVS with an
SPR AVS capable PD source. This allows gs101 to negotiate SPR AVS with
a SPR AVS compatible USB PD port partner. The DTS changes for gs101
will be sent as a separate patch while marking this topic as a
dependency.

This patch series also depends on the "Introduce Sink Cap Extended AMS"
introduced by Amit Sunil Dhamne as it introduces the SPR AVS voltage
tier constants which this patch series relies on.

Depends-on: https://lore.kernel.org/lkml/20260223-skedb-v2-0-60675765bc7e@google.com/

Badhri Jagan Sridharan (3):
  dt-bindings: connector: Add SPR AVS Sink APDO definitions
  power: supply: Add PD SPR AVS support to USB type enum
  tcpm: Implement sink support for PD SPR AVS negotiation

 .../bindings/connector/usb-connector.yaml     |   5 +-
 drivers/power/supply/power_supply_sysfs.c     |   2 +
 drivers/usb/typec/tcpm/tcpm.c                 | 611 +++++++++++++++---
 include/dt-bindings/usb/pd.h                  |  18 +
 include/linux/power_supply.h                  |   3 +
 include/linux/usb/pd.h                        |  32 +-
 include/linux/usb/tcpm.h                      |   2 +-
 7 files changed, 563 insertions(+), 110 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
prerequisite-patch-id: 4dacd8bc550e317d67134d030814765fb9f4c6e1
prerequisite-patch-id: e863378fc602b6bee2e9fdd8c568003c00b2a38e
-- 
2.53.0.414.gf7e9f6c205-goog


