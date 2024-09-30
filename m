Return-Path: <linux-pm+bounces-14979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528A98B0C2
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 01:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A75282C4C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 23:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ECB189502;
	Mon, 30 Sep 2024 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+xqS8gj"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7945339F
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738541; cv=none; b=Ck5mBXVskSvMWXDHxeac9sBohgRWHDsQThJS8XoLyWqYwvg3/y5rWu4aBRpE8xxbf/96PGliLpOoFPCdVVtXlnD36BN+q1rNOtViTikakCDz/Qs+y3T9T8NCdapVyM2KmOCX0/Irm78K9YC4mDm+Tk/LMNKnCtqtFAxvFZ8VeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738541; c=relaxed/simple;
	bh=5wMoQerhVfNthdnWkyVLl81spGHlLzs98yiY6oorZLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5ybbKLEfihXXJ+3zMx2ub9xz7+vMRNmhSta2xEcjaVJ9ql/OU7s1w5dSYWhPc9w0yMLmymsMqU4NugXRol+0QnKSu4u8z+4erupccn4D/t4XKb7483boY7f5iUpMNv9RFbRfN0q+Qb23S3c7aPxCTzP+cIiYzKg/VAMB+9TSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+xqS8gj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727738537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cw3TyvDfm5lZoBfW+yqVxJ0cUAPR/u8ZzH97gvuXA9Q=;
	b=O+xqS8gj1hMA6E88XbXpWfcDLXduYuoOrrB6l2pS3vG1Jgs9JxbPfPhOlOJsSOqpDzANBS
	9kPOG0c2R1/31G/97gWmZOTprX+6UsJ8P/eOplpwpY3kA8sPKUecjADltERSLH7eH83J7B
	u22FHQ29+QbKbjGFQDODYuX7PmMWzk0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-G5l0YcWWOnKqI7vWGyZNyw-1; Mon, 30 Sep 2024 19:22:15 -0400
X-MC-Unique: G5l0YcWWOnKqI7vWGyZNyw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7c6b192a39bso3989846a12.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 16:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738535; x=1728343335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cw3TyvDfm5lZoBfW+yqVxJ0cUAPR/u8ZzH97gvuXA9Q=;
        b=pUxRjVBzpvxnC2OEraq8nC6Xpg3k+x//GMEg3i428X5Mw+Uze8Y+2wMDaNtcWho9xf
         2W1byL4ugUHp+ORKQQHEEO55ImC1R5nWYBGo6OdBAN8OkVm6U6QOsG8w/OfDGpUhKIZg
         Bq8HMop/d9Z+KCXYrnIyr8L9imbtqI+U0iQLgTNqzkSzCL0V7LFtwEvIldNlx+8yFvvP
         cAJaTZukr9NfD8WGtWXz0qOgDpjbkumNlIjLWVc71cPrvM8vuLIAypqChOiFeYif7Qf1
         iXZlLrZcUrjP62khVkQ278Rf4nYzNXmQTIkXxU2buITFSs00PFMKHtL2qpVLDEMD8jDt
         NUHg==
X-Forwarded-Encrypted: i=1; AJvYcCXSUvJg+XNgfopNn280E46b5IlI9sOBYGPU9YU26BXWKUiw5rP9vrqnOMJ+Ic2W2pSrsHv1YHQgIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9t+gGc5IhdpWsGNHL6f+ps09cbSlJLBU6ApP5v3kHI4R6RwQS
	e2icnOU/UCnT41NZIb68CdcySo1fJHGrPqsWQL/ONoaoRvPxtkFuunEWhGpd7BdzVlqH1Newzxz
	dcH+XFnML2NADBQwClNkSDCUzt/MmH+dkT3Xgp/HKUoc8BCioKfW5l3st
X-Received: by 2002:a17:902:ce88:b0:20b:9998:e2f4 with SMTP id d9443c01a7336-20b9998e604mr29141625ad.61.1727738534848;
        Mon, 30 Sep 2024 16:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFPJ0xdEclTCdVD0Cc7sUcJpQzyM5nnJoWiGEd7ndTGfu+IiZLg+4emBGAIZlH0JO0quOIjQ==
X-Received: by 2002:a17:902:ce88:b0:20b:9998:e2f4 with SMTP id d9443c01a7336-20b9998e604mr29141435ad.61.1727738534544;
        Mon, 30 Sep 2024 16:22:14 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d685b9sm59241985ad.54.2024.09.30.16.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:22:14 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 0/2] pm: cpupower: bindings: improve test script
Date: Mon, 30 Sep 2024 19:21:53 -0400
Message-ID: <20240930232158.29024-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve test_raw_pylibcpupower.py with some cleanup and catching more
states. This includes confirming states have been disabled and a notice to
use sudo.

John B. Wyatt IV (2):
  pm: cpupower: bindings: Improve disable c_state block
  pm: cpupower: bindings: Add test to confirm cpu state is disabled

 .../bindings/python/test_raw_pylibcpupower.py | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

-- 
2.46.2


