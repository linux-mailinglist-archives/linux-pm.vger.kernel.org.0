Return-Path: <linux-pm+bounces-11632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FECF9408E9
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 08:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D659285063
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 06:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD7218FC89;
	Tue, 30 Jul 2024 06:55:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC518FC60;
	Tue, 30 Jul 2024 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322503; cv=none; b=lkSNfsz14yZWoBzBp85eOEoXfyF6H0Jj2U87kbO11bovbCzwLefM/Z8LOUesun7lDeGziWucCiqiBCNK4YV62LdwWHeqFMMPo5tRzPSXCn1QrZmtcAjG7VQqU72HhsjGMYQ27f58cqaEeEt6YQ6HJ95QSBBFhawPcp/LBZvBTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322503; c=relaxed/simple;
	bh=btrwPo1bTnX+OtgF2jF7AKgCHzwPRTVZrxoIXJOQ4/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F01k0IjBdaqtl1Az35vGsR6dZ8tbAqPFfniThuchfOzohIk1KCSSy6hsV7PK7jwEYZIc05qzLeHTV3pZb5j+1jP/V+qJPFmIVteNqQ2OOt31EziivYsLOSIXxvw/GrMv3rIGupF7W7d+4UNTJ5une+T0p9xEwtQGrBB4pKs4VkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1fc65329979so32549525ad.0;
        Mon, 29 Jul 2024 23:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722322501; x=1722927301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYSBXwvruaHh7b0PdTKGrHZXGYlAm+6EuZ78Vav1MPc=;
        b=xKy6zuMMwyZnWGtvIs0irf1JpZy2Nwqi6+ot8pWyq1zbwUgESybYwcOAbVz1BzECTG
         /0xZf0JEJ268mUvlijTgbYh5rddi5S0GABRYSa0t8XbTMvuZ1l2Q84BU6HJO/GEYKeUg
         6RyJcMbfl3kLcQaMnNOPDorxCJeJHauleTjTxzmu5qu5azFzjVuIVDaGuYPTwliUWKkQ
         c5+cm70vCFrfZzYT7PJlfw5vfoK87Z76gc3QebA44v7F0gj2Ai260v9CwLiQVf5LVKXa
         TgEteaxbQSbArAGis+/Cgh/TZomR8J+DOo3qtzU+eyZC0/r376aqblsOl3uuHCgS5X2P
         HWTA==
X-Forwarded-Encrypted: i=1; AJvYcCWywagYkZDBndMV5SJ7SM+xhaCIyA2Iq+RPhEju4rzWKYkuSCaY68B06kyKxwptNgw08sTuxusvy6pbSuaujQP9+Xe7/aRvu2umPaRa
X-Gm-Message-State: AOJu0YzAPBr2dua1yDnO8lpXxqH9qyrPQlsHW4xyreIcfiqaiC6riz5S
	eFeVbk9qYnQ7AH9Clr/XXPhpCfhz/I0iq8ZndTOE842Bd5bW0wBp
X-Google-Smtp-Source: AGHT+IHeJ0V9N6b0Y10vxMofQJnDQLGVUEl03wQPW2MTczewmos1VHaJhY+jlamEOQP15l2mfBmSzw==
X-Received: by 2002:a17:903:1245:b0:1fd:93d2:fb76 with SMTP id d9443c01a7336-1ff04852a8emr135213545ad.31.1722322500942;
        Mon, 29 Jul 2024 23:55:00 -0700 (PDT)
Received: from localhost.localdomain ([111.48.58.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1aa18sm94392875ad.190.2024.07.29.23.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:55:00 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	xiongxin@kylinos.cn,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [RESEND PATCH 0/2] Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Tue, 30 Jul 2024 14:54:52 +0800
Message-Id: <20240730065454.2096296-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Documentation/filesystems/sysfs.rst suggested,
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

No functional change intended.

Xueqin Luo (2):
  PM: hibernate: Use sysfs_emit() and sysfs_emit_at() in "show"
    functions
  PM: Use sysfs_emit() and sysfs_emit_at() in "show" functions

 kernel/power/hibernate.c | 20 ++++++------
 kernel/power/main.c      | 70 ++++++++++++++++++++--------------------
 2 files changed, 45 insertions(+), 45 deletions(-)

-- 
2.25.1


