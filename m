Return-Path: <linux-pm+bounces-19626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D009FA0B5
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 13:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B97A1FC9
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5245F1F2C45;
	Sat, 21 Dec 2024 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IY7P+5v0"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809161A8406
	for <linux-pm@vger.kernel.org>; Sat, 21 Dec 2024 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734785514; cv=none; b=jFTJeV5qeyCfauAMo75OI4gDDMKiL5MxXIqANCARK1j5Y9WxOppl2gh/MLCgP7kUYVRSV9pB/5upHjH3ly9pYSp+1qDGZ7qn2qiil41lG7FimB6nhHgFKGpqe7CumhkTkgAHDNeOz/y6KaZvmkmbynwjTsDBdPCr92f3T5ljGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734785514; c=relaxed/simple;
	bh=ftFqeXJlr7ozSsJiJmwDqttcOnaO3TPQ4NZq5jR1kpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rbal+8kEjzEHreOOdCOMs8Jv02mdwWspib/pHXPhZjzO2Qgnno+5lJM0OZ8SZkf0pG95m7rS+XXDRQCdUb+XT5iGMyUSyWfN6wguwANfCv20FnacLqCt55++gUMDyHwZr+h8JAdiMAk1PSICDi2o5bfX2GzffPRn5g74iGU1utM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IY7P+5v0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734785510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DMdR9EaqQqpEHfKqP+5Z9GMZ9uoTPMuFThXtBArLjI8=;
	b=IY7P+5v0y0MAdsPtZRVtFxJpCEZQ/6lPZFAeoXHeCa8xu+UM0DMZwnYPDB4ZAKL6cCFoNs
	nKYai6SRhB33zYM7puXcVExWbMI0LiwFResvCDbjJxObxiAXIZwSuqELU25BI7K29ujD9H
	JR6f9UXtccfmJwinLJ6JqRgZ932VJ6I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-PjvPJLMuNqiJwJftw3LRbA-1; Sat,
 21 Dec 2024 07:51:45 -0500
X-MC-Unique: PjvPJLMuNqiJwJftw3LRbA-1
X-Mimecast-MFC-AGG-ID: PjvPJLMuNqiJwJftw3LRbA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33C0F19560B1;
	Sat, 21 Dec 2024 12:51:44 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9A4519560A2;
	Sat, 21 Dec 2024 12:51:41 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 0/1] power: supply: Add new "charge_types" property
Date: Sat, 21 Dec 2024 13:51:39 +0100
Message-ID: <20241221125140.345776-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Here is v5 of my "charge_types" property series, most of this series
has already been merged, leaving only the dell-laptop patch.

Changes in v5:
- Drop patches 1-3 (already merged)
- dell-laptop: Return ENOENT instead of EIO in charge_types_store() when
  the requested mode was accepted by power_supply_charge_types_parse() but
  for some reason is not found in the battery_modes[] array

As already discussed since the dependencies are merged into
linux-power-supply/for-next this patch should also be merged through
linux-power-supply/for-next.

Ilpo, this new version addresses your review comment, can you please
provide your Acked-by for merging this through linux-power-supply/for-next?

Sebastian, can you merge this once acked by Ilpo?

Regards,

Hans


Hans de Goede (1):
  platform/x86: dell-laptop: Use power_supply_charge_types_show/_parse()
    helpers

 drivers/platform/x86/dell/dell-laptop.c | 54 ++++++++++++-------------
 1 file changed, 25 insertions(+), 29 deletions(-)

-- 
2.47.1


