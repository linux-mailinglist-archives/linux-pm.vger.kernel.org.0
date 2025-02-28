Return-Path: <linux-pm+bounces-23188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59957A4A113
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 19:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285A1189943A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAF2274253;
	Fri, 28 Feb 2025 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxbxEygM"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D51F09BF
	for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765895; cv=none; b=f9zkb43bAGnVIJbCxJkfmXVqtc07YxRIrji0wTBrd3EyTA1fvgEeZrvd58UV5SltMfL9DrOSgaC20zYArITICsED92I4F/2VuqFX3wknoAqbHtqttvNCi9vgcODXeVOg13U3VRFlzRWEHYsZEzDZa5tQG1spWv/10rcaMigKjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765895; c=relaxed/simple;
	bh=+C63huvz9dQGQOI5cfX7d5RKsbMfZLU6xOliYCIP/Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lFlmfBJONow9rAFxjN/3vs0ooKusMV4FjeH6+SofOmsm6HoX2faTySZbVrI3njXLU421urfUf8jpbcWHuarDyeh43CI2RqTQ/jURvuNl7OFdSNdmsglDIXvOhMwpdCoEQUsfBS3RsTGuP8mT1fA6fw4QP2nhU0JJ2AajGXGko7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxbxEygM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740765892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AZDqWqvX3KIhyPrkQxnZsW82KV75OnrWdYAqDLbYagk=;
	b=UxbxEygMFjET1e9LO4OnQigoMYyFta/Q/egTJ6j9fpz0hLhO38LtDFgCrIdfwPC8obhKdF
	syhP73seJEtNv8GbaG0CJCUeAbPFYFWb7vCPv4U5ul5pA77ia7aHbD6wfWOqgHbaqwoyKB
	1bdrza2sdNEwH/cqEKorfBr3TvZGS0M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-lOD5CCCiPEaAXg5soMDe9Q-1; Fri, 28 Feb 2025 13:04:49 -0500
X-MC-Unique: lOD5CCCiPEaAXg5soMDe9Q-1
X-Mimecast-MFC-AGG-ID: lOD5CCCiPEaAXg5soMDe9Q_1740765889
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8a04e1f91so39823016d6.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 10:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765889; x=1741370689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZDqWqvX3KIhyPrkQxnZsW82KV75OnrWdYAqDLbYagk=;
        b=NLS0l4Ju7Up6GovJI0gd11qBVqjBGpAc76sNxje8CTZhzk9jfZ4J34Is/LX6lt2su9
         9Fc9A8zqv0clAlWXWUaHZ2bc2AO5Ix6ImfkE4fsK9ys2xuuqQjZ46c3EAqxGoW34q9O5
         Juh3NCIge7tWK3Igyl5cRdhUDTuBuUavAYrSds8SxRLY/650iSH42gfkAM9rHfsA/sjk
         Si2hyH0KCbVDM6yAbi9/F7DJOVL+p1oknRa3FkKJi5gT1H5E0cYCNRWZ0UE6ipvlI8/q
         KjP5SSFrwrvQbMaZzphmUi5DHtEfDu/aJizkwQ6LNL7hwZsAOUrOnBh+tH5ZYcMbdQhj
         uxOA==
X-Forwarded-Encrypted: i=1; AJvYcCUl4myZ+nu10cN3C+0FYQvFsR+ZLQi7wTeAcPgT5xGOYQiZcEroczC1qfB1uhQUNxRQ54E+jKnXjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrROyoSavYLb0CcYeQTS+SlDzBLFZgwPL/nQqK6zQbdHixXMYT
	DNPYTD8Q2ZwV8Q3nEm3Vg4yFmlaXgbGd62sO8zAGZZT2gtBsnYfnEcITn7c1WCtiNgKWXyFDSyQ
	zaHSxSETb3+DP+wDw2Cgns0P/qrxoMvZhDaENRZCxc9BxPmeDegx55kAt
X-Gm-Gg: ASbGncvogUnZfPOwC0bZ5qPUhqn6QsKGyPnLldRqrBxERPiuk+1bDrc/owHgMdhwYgK
	JUP7k4GEQ+Jwc9clsVKIWjmemIlNWeCRNI6VT+/wX0OYP/EVZq3MD3wUOc+m0eE2u59uTaInKja
	oPy0tgbQ2eOgzIR1YuDdrbfD2XP/UcOSlZPmaeZ9GW5UF1qwO4/i3AwAubs+5cSDhslImiVkBee
	XRFf0QrL3pCxBDtkW91sodemORdftjfZbAPGrAO6WtvWWJdiq/x417Fs752qi2xXZTga1btAio7
	asy11hqbfi8nNDpYwkLJvSiNahpplvOQr0FYY37Z6VdkUecRyJiXXL8ytLpRCv4Ji51afui47qU
	=
X-Received: by 2002:a05:6214:2629:b0:6d8:9124:8795 with SMTP id 6a1803df08f44-6e8a0c80eb4mr60662476d6.1.1740765889060;
        Fri, 28 Feb 2025 10:04:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsDW8INo1WX4MuZoVASIHZSK4OnKzK+xAJb2//PBTVZip9R1uvasXM9h9/bkMhmLPBRWhf0g==
X-Received: by 2002:a05:6214:2629:b0:6d8:9124:8795 with SMTP id 6a1803df08f44-6e8a0c80eb4mr60662096d6.1.1740765888584;
        Fri, 28 Feb 2025 10:04:48 -0800 (PST)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee8a08sm274654485a.6.2025.02.28.10.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:04:47 -0800 (PST)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v4 0/2] nvmem-reboot-mode: support small reboot mode magic
Date: Fri, 28 Feb 2025 13:03:24 -0500
Message-ID: <20250228180326.256058-1-jberring@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

These patches allow nvmem-reboot-mode to handle devices with a
reboot-mode cell smaller than 4 bytes, such as Qualcomm SA8775P. Without
this change, nvmem_reboot_mode_write() tries to write 4 bytes to a
1-byte nvmem cell and fails with the message "update reboot mode bits
failed" on affected devices.

This issue previously resulted in an out-of-bounds heap write but, after
one of my patches from v3 of this series was accepted, it results in
that error message instead.

[1]
https://lore.kernel.org/all/20241104152312.3813601-2-jberring@redhat.com/

v4:
- Excluded one patch which was accepted from v3 [1]:
	"nvmem: core: improve range check for nvmem_cell_write()"
- Handle truncation of the reboot mode magic in nvmem-reboot-mode
  instead of in nvmem core.
- Introduced nvmem_cell_size().

v3:
- Accepted suggestion for changing nvmem_cell_write bounds check

v2:
- Added missing function definition for CONFIG_NVMEM=n

Jennifer Berringer (2):
  nvmem: core: add nvmem_cell_size()
  power: reset: nvmem-reboot-mode: support smaller magic

 drivers/nvmem/core.c                    | 18 ++++++++++++++++++
 drivers/power/reset/nvmem-reboot-mode.c |  9 ++++++++-
 include/linux/nvmem-consumer.h          |  6 ++++++
 3 files changed, 32 insertions(+), 1 deletion(-)


base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
-- 
2.47.1


