Return-Path: <linux-pm+bounces-20812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB2BA19409
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 15:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351F4188C85C
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6F2147F9;
	Wed, 22 Jan 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CirrlU9o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472672144C0;
	Wed, 22 Jan 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556506; cv=none; b=t2VfsncPb/pr1PpcmmksHFtTESmctBzoeUINgmteq0LX8elrUk2quvZVnQeB2NZDtzvooptFPP+xjTRQ1CSGo/N+rwkHdzjM+xP7RoKCHR+/fiXrB6Z/f7mJdmyXNrhSFDaO4T4dtZTQkbdI90k5A49bYMwyHnDdri6zaF1RJsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556506; c=relaxed/simple;
	bh=J4YCNhjzRigTVeF91bO9CWOB5TBbIWJrhq9Bz5UxP7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKI1b7K4RB4OBzeQh9LrTTQcd8hQLwogmlYBwRJKTATiB1AZB9segyjsdQYs/EvmD50eaf97SctX21YwgCxSLUXUOaFclazrJkPBx8gBtIiIzo/aSsC5GPG039P/bcTNIGvx9d1HIC54KKVQFeAH1Eif4GL/QZRZBPnblvYr6d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CirrlU9o; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so12004234a91.2;
        Wed, 22 Jan 2025 06:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737556504; x=1738161304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExI6PFCsF9i13/QhbBlPnnrsT656rvvJkTyXY/Jd5OE=;
        b=CirrlU9oJtkSYleeQhHdjhHl8+p7B6IBye0XRXmp5TkERyg80IypxIeAjEuSDA1o/5
         rPiYFPY5meU7v369dcEIF3IAwge+XMp6toyEwHyaTEBJL12zWr8L0pWfjB/uyBJY34N9
         g/Q9b3L9VQzkIyfioAJVDZmvrhIQpwUnBjWZBVw24CUNlxCJ4YyFzfdU5NwZ/IayuTde
         Tmrl+t860tp+ipPWjOqY/MwKCJ0pctHjNmhZklHe1VUpH0yZr/UNom1bh3fNCLzAwQGT
         XuyL4JOngdqGN/JHN22s9IGZcBDDxOZ5zCfANbcIi+irXMryKZCwwUbIxLB7s9D1mV3f
         Rh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737556504; x=1738161304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExI6PFCsF9i13/QhbBlPnnrsT656rvvJkTyXY/Jd5OE=;
        b=pCzOkY/W2srfhT9ah/gVVWTvSvFkJdLg/1BsoW5KfrliC89exKGHtHc//rw5wqY9tW
         Syad7AAtnSrkM7IC/dmuptBCNT9Z0zZXcQsvgyLo9uSZR09J08KTlfhyvdh4GR1VQh3b
         2SNFV4mUhCETprUW65tfkCXKQQLovwb4l5Aac5k7JjdTj9lCCTVxJyPZuO/N5KtkKig8
         s7bV6ZWsidmhOQvpVn9BcmjGz3NmnUNqRHYBqVlJ8Ql/Kb1p9LFvY7K1nY7+AvQXqnhC
         xZpO+Suu853crBg+fCSOunObpMyPF6IzF8B6P7HiUGLJ0lL8r18EbiPX9Gt0LcBNK/yi
         YyEw==
X-Forwarded-Encrypted: i=1; AJvYcCU0roqsqAfnjSM6S0IpajlFjzgnX0PD35awZnTIA//g56RWz3jG9ofUG7Cr1rSkmc3rBFp69Mxc69A=@vger.kernel.org, AJvYcCV7DncMsT4/9XkNQt5yfhCUInwEk3UVQ6zTcgYiEJ+D+Co/nQX1i/rarJvEsSKfyXTzuhWoDF6tspdjr73j@vger.kernel.org, AJvYcCVyUv5k4jWYj08LtcLT4Qdq2EilXhUiWKjuX5zVeAW6ShEXV6rYr0jiGV/K9cBTCTKKZ1MY2wYypFmy@vger.kernel.org, AJvYcCXpnjiYRL+1Wcqcmh21PtLCtS+/Hlxe9q9klLC+TE8CJLX2rqw7qv3kLx/d3234cIGtcV0AAZ6JWvLPCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzX8ctSujNVBAiPSqROZmVJII1IQofhvhKVWy4e6pbBaK8SDZs
	fwY/083iAUjSd9n95mVSY28KBgK1wsDGeL7fa+s32lSnTl1Y7oPc
X-Gm-Gg: ASbGncsx50abM7JSJcbUip82H4V94inAFvKBkT96Di1q6nMcr+KvzFeOfaoi1qRlGsg
	GQKEPOjwWk9PSIcy3v7K7L/EL3t/eUIYfCv/63PafQjfGaLFRWZI6QzTvN4X3A/wA/GNfoqmymW
	RILAcACBPeM5vnoyVhuMfFcecwiy2qKkfu1b4lKRoCtGwlU4DtUJkCUCNdZUy1S8yioropoC5YG
	3ueTOrZqzHBkixkuyB6oMXvG5UkOt0qioPzLxHWP2Sh/2R2FS1RbNt+meXqDHLeIMJuHA==
X-Google-Smtp-Source: AGHT+IG/qGJgCN09y0M/h2JakVGEvnk9yLNn7E9Kh6ZREODnOxE81Xo82L7B9/Vtt1FSjB/bkpckUw==
X-Received: by 2002:a05:6a00:9087:b0:725:f1ca:fd75 with SMTP id d2e1a72fcca58-72daf9a5514mr30249346b3a.2.1737556504349;
        Wed, 22 Jan 2025 06:35:04 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72db5ccfd53sm10715126b3a.144.2025.01.22.06.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 06:35:02 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 09D8A41E8D11; Wed, 22 Jan 2025 21:34:58 +0700 (WIB)
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
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/3] Documentation: ublk: Drop Stefan Hajnoczi's message footnote
Date: Wed, 22 Jan 2025 21:34:55 +0700
Message-ID: <20250122143456.68867-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122143456.68867-1-bagasdotme@gmail.com>
References: <20250122143456.68867-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=bagasdotme@gmail.com; h=from:subject; bh=J4YCNhjzRigTVeF91bO9CWOB5TBbIWJrhq9Bz5UxP7w=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOkTGfXbU55w/fdWygk16WzNCZz7fM6ErokejbevRLSWf elmFuXvKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwEQcJzH8d9cIeqK062aaLOdc +3Kx2979/y4Vcf8WFth7dFnQxgVSjIwMVyMM1odLP3c5uYy7KH/3RVX3pORpy94dbDxRuyW/T7O NBwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports unreferenced footnote warning pointing to ubd-control
message by Stefan Hajnoczi [1]:

Documentation/block/ublk.rst:336: WARNING: Footnote [#] is not referenced. [ref.footnote]

Drop the footnote to squash above warning.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Fixes: 7a3d2225f1ae ("Documentation: document ublk")
Link: https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/ [1]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/block/ublk.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 51665a3e6a50cd..1e0e7358e14a96 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -333,6 +333,4 @@ References
 
 .. [#userspace_readme] https://github.com/ming1/ubdsrv/blob/master/README
 
-.. [#stefan] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
-
 .. [#xiaoguang] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
-- 
An old man doll... just what I always wanted! - Clara


