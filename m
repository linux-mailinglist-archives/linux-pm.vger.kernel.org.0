Return-Path: <linux-pm+bounces-20810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E6A193FF
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 15:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F257516BB8A
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22921422C;
	Wed, 22 Jan 2025 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Owes9VWH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148538DC0;
	Wed, 22 Jan 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556504; cv=none; b=BDKoHbniL1WHAAxBiP5b6Dcm2U9Txn4VR0EFIahnU7pNHzKLo8tspIxm6sB5zQgVvJskjwsejl6pAi4z7KJVUen7c+miEvigDY+Ql8APx933vr/CjWSVLVmOjQrFWZCmI0hcfBAPHB9gGh/8uoDFY3JdQD3pcFpiBgICobzP+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556504; c=relaxed/simple;
	bh=kK8h7xLBIzPsw1VKaFBDTNNqKoF3JPJbiYx6352zuUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2WMiRvReWhEHirZkMGyJ7uE0kmKNWokcboHzcqUdEcd64KYqVhZR4iSCV+BWKWDzecSieOdWLqduMg9L4TdbZeFrhW+ZQFk4FRx16W9bnnv3Y0Soa2/V6GGVjR2jiuX7OsjlIGUKySWDMIwuahpYZ8R18dQa+0AfR5mkCWnG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Owes9VWH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21619108a6bso121200855ad.3;
        Wed, 22 Jan 2025 06:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737556502; x=1738161302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqJZ0B17C/QFiuxg4Z0TlsiA5NUry4lUYiqLGAeozHc=;
        b=Owes9VWHgrO1PZiEBv+hG/h3CCV23SC1ud1Kre4h01TOpQRvGFX7LxGsqdb6Z3d24l
         CgGFYqUBOrdBNvnwmjbHoK+jbmfbdOxc3dktvLuRuhE2vW4kLix+mDVdgLQUCfrDSgVT
         n03UH7Ip9KnWTcDMrB56VIloUWDSC9ALSx384WmFakMPyhdfnx18vcXRvSdsa+YdttjW
         KDy47K5DI914qUUz1F/Shg38xZluy7Ql9K94yrLPrs53lNJnoafXxTBqs3Fa+Qoz7QtG
         Ymapyv6m69MrRz2f+R+LrKy656HGPFOvRh0yNt2L9LVJqTaB3YazwKSFfzees21jVoLq
         VUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737556502; x=1738161302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqJZ0B17C/QFiuxg4Z0TlsiA5NUry4lUYiqLGAeozHc=;
        b=rqRrXgrP6Jt2G0lqcNsJd0BEQWbSopqq3jAbDDdptBL3wGg4/t4t4VM64gtei9KXkA
         eL7oB5OXOY9zCXafWwNfLVNdsxrr8JLJWKuHs9zgwzbVGFWkfxAlFl/CuT0B9PmAiIDD
         TJWnhiofM+OcXIkxWEDn6CQiRletqtttPguWKD67Cj5cEw5FLDu4X8uNb55kOjCwkDoE
         oi7+/hUKP6v51LZaUaQHDkfu7Cb4DBxwde/jUxCE1+Kl4zQnzC2D12QryD9V2noyAtkJ
         slacBM6ZEoerY2gooaRR2pK04LQTqi3oWxThADfEE695As+mAy9uhi6qj5Y1r21cKlPE
         mQlg==
X-Forwarded-Encrypted: i=1; AJvYcCUWUmoxSFOTB/APzSp2VaCqqaHcg3j0W/pyyXCMCWvCvOEHLlCe4n0iwGbsllPdk5S4rIkge4EFQUG/@vger.kernel.org, AJvYcCWBcH+pKDl9Y1xoO6jYJG3MqBRCJkC1ZuLGtv5TnYzkU0JNOKGfsyR5xO0wcCH3Nsjm7nm6rcARMSNMdpL4@vger.kernel.org, AJvYcCXDGGGlQqRAvdGsR1QEhraMjK8D+cckNR3xlypxVFEOKX5PhQvId9jRV7new+dmUw8264nHjPQ1e1iqKA==@vger.kernel.org, AJvYcCXaDyGxAvAJ089PrAI5SmvG89O626jRzgp5vr+xqb1LoRQTiKBsUYBpCnJ9Yg7xCSjv6cdDlmELQCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJJ7ytTX2XbKGMUllfobE/j53ltBG1wDo20GC6nUiHEc2KlRb
	7V7+BzrFdmSjq1p2aQznUqTaWjuC1ZRtmw9jtAziBbUHimU2njed
X-Gm-Gg: ASbGncu9HE+9QAObVZxlXc6vZr1TiKVNM4yqcLxdJYHNnEjLfHZpgFVZfzNOVyTGUfJ
	U2DIJZgCWyoxjE9JxNvhfchk2b2GB1dBoHOw9BKuAbYh0m7/hSvMLfNHMssJwx67kMXfT5A8cvA
	xUOnnDDmCRdhEIfAZwqUPy94dYZ7ghOpG/nJqTZh8w/1jqdiIkm3v8whmW892C1ZXfWjQfLfSvE
	w3t5w/eZ3LEAYKrcryM6okqt/cXFZPBcFIb02Myt0y7Svma50HR80RavWL6AWhYbQdTpA==
X-Google-Smtp-Source: AGHT+IFOb2ZjmXA85XJnSrWuiW/6Ettwnat9B4bNw4q+ceJCYBLk8GlAznMag7vwyBrrVf+WMImL2Q==
X-Received: by 2002:a05:6a00:21c3:b0:72a:a9d9:5a82 with SMTP id d2e1a72fcca58-72daf8878c0mr32294986b3a.0.1737556501983;
        Wed, 22 Jan 2025 06:35:01 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab8132e4sm11118813b3a.40.2025.01.22.06.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 06:35:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 31A024244586; Wed, 22 Jan 2025 21:34:58 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Media <linux-media@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 3/3] docs: power: Fix footnote reference for Toshiba Satellite P10-554
Date: Wed, 22 Jan 2025 21:34:56 +0700
Message-ID: <20250122143456.68867-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122143456.68867-1-bagasdotme@gmail.com>
References: <20250122143456.68867-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=bagasdotme@gmail.com; h=from:subject; bh=kK8h7xLBIzPsw1VKaFBDTNNqKoF3JPJbiYx6352zuUg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOkTGfUnHxFddvCC5T8jLo9WEe7zqYosj0TkvfXiJ7V+j vyyLMi8o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABN5ZsrIMJ+/Njb/eMv0zNPy 8/tdmJX5ih5ffbBrvzLfhK5oLUFuC0aGjT8OVPsHTM4+9Ptq88m64POHvzMl+1Z+OpvzsKx4jXc /JwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports unreferenced footnote warning on "Video issues with S3
resume" doc:

Documentation/power/video.rst:213: WARNING: Footnote [#] is not referenced. [ref.footnote]

Fix the warning by separating footnote reference for Toshiba Satellite
P10-554 by a space.

Fixes: 151f4e2bdc7a ("docs: power: convert docs to ReST and rename to *.rst")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250122170335.148a23b0@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/power/video.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/video.rst b/Documentation/power/video.rst
index 337a2ba9f32f0f..8ab2458d130437 100644
--- a/Documentation/power/video.rst
+++ b/Documentation/power/video.rst
@@ -190,7 +190,7 @@ Toshiba Portege 3020CT		s3_mode (3)
 Toshiba Satellite 4030CDT	s3_mode (3) (S1 also works OK)
 Toshiba Satellite 4080XCDT      s3_mode (3) (S1 also works OK)
 Toshiba Satellite 4090XCDT      ??? [#f1]_
-Toshiba Satellite P10-554       s3_bios,s3_mode (4)[#f3]_
+Toshiba Satellite P10-554       s3_bios,s3_mode (4) [#f3]_
 Toshiba M30                     (2) xor X with nvidia driver using internal AGP
 Uniwill 244IIO			??? [#f1]_
 =============================== ===============================================
-- 
An old man doll... just what I always wanted! - Clara


