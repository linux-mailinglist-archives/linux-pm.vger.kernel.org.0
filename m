Return-Path: <linux-pm+bounces-25371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3815A881A2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 15:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7530D16BF6B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF48329C327;
	Mon, 14 Apr 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeEfTbiI"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91A2D1F6E
	for <linux-pm@vger.kernel.org>; Mon, 14 Apr 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636771; cv=none; b=TgaIbXNv4fF70QuincdFHHzdhhnsN+JmZAja/2VapyEHL+w3pzbzBngalW0t85pz2DDD8uNDkaFcJ6CQiXjMGtjYt3Q2zocoFx66JHwTk3eblnNigYAtM8Vu/7zJKjiHGm0j1UknhMb9KPHjTz9UXLsnT8CkI1Srqhlh4ygWv/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636771; c=relaxed/simple;
	bh=KyKZ3ufkEQe3K5p24FQ6yx+x877Wi04k+RBNX2F1xW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5TvsdNM31OyGLFlZ2ezWzBH0K4z5EM1QqsgUeHqIxtE5ypRzu6SC9DpAdzmNpYIo433meuimp+zTFTql4TxNhaZr3x6XxSEasWWYY5bH3I102k9f1a9VlSuY/R9iJ2vhJKeC6P2qr4xD3ujzupsa1cRhAlZtu0EFYiFQoluBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JeEfTbiI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744636768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+QZ3tghRcLpy9psREtTvIDG6cbVFr5jPCan3SZyejlw=;
	b=JeEfTbiIgXe9L93N+Doc8he2Qp1hQQMyXXHg+6tgjj617ITYz06Gvim2twg0vBimTQjnJP
	RFiRW0eHB42JjlOjnR+if4//lGsV4xy7Rc6GgD7YIVyUpFrGdJUXq2eVCIavpJfzJhE1ci
	LroEkEI2V/3LG/USYUzK9iwdVXbRt8Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-s4ivFx0yPnGT2e5Sl8a_7Q-1; Mon,
 14 Apr 2025 09:19:19 -0400
X-MC-Unique: s4ivFx0yPnGT2e5Sl8a_7Q-1
X-Mimecast-MFC-AGG-ID: s4ivFx0yPnGT2e5Sl8a_7Q_1744636759
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F09E11955D82;
	Mon, 14 Apr 2025 13:19:18 +0000 (UTC)
Received: from carbon.redhat.com (unknown [10.44.32.142])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 555063003746;
	Mon, 14 Apr 2025 13:19:16 +0000 (UTC)
From: Jelle van der Waa <jvanderwaa@redhat.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Jelle van der Waa <jvanderwaa@redhat.com>
Subject: [PATCH v2 0/1] power: supply: support charge_types in the extensions API
Date: Mon, 14 Apr 2025 15:18:39 +0200
Message-ID: <20250414131840.382756-1-jvanderwaa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The goal of this patch is to make it possible for the ideapad-laptop
driver to move from its custom conservation_mode sysfs attribute to the
standardised charge_types sysfs attribute with a power_supply extension.
Along with other laptop models which support an end charge threshold
which limits it to a fixed value such as some Toshiba and LG models.

User space, in this case UPower would then be detect 'Long Life' as
charge_types option and set it.

This patch should also allow the "dell-laptop" driver to move over to
the extensions API.

Jelle van der Waa (1):
  power: supply: support charge_types in extensions

 drivers/power/supply/power_supply_sysfs.c | 23 ++++++++++++++++++++++-
 drivers/power/supply/test_power.c         | 20 ++++++++++++++++++--
 include/linux/power_supply.h              |  1 +
 3 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.49.0


