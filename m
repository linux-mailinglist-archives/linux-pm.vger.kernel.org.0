Return-Path: <linux-pm+bounces-20809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD7A193FA
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 15:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABDE188A413
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40D5213E6A;
	Wed, 22 Jan 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdNi/no0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AB1F94A;
	Wed, 22 Jan 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556503; cv=none; b=KNOwy3aayS6kVgrBiEphadRMwV+6zqWS4t7X2sEFjArH7xYm+jRagVnANdZqUsmgeLVLemDq5FoSfbJiqNzUH+MibuyMuFRsWuvhh60HpxPLB7TRGjnGLLe1YK/XWGmEMrW7docQw/xrLz6tdpnaTGU5bJMXqr/bI3gsXLlD8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556503; c=relaxed/simple;
	bh=m8lx9id+N8G1oRBTTUZ2U5IdfXbQFt9T4fAAHi4VtRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYGtNDk6FALR0sWQ6wQwjZ+J+kz3NoIQuvXXdGhBiKieH0QWJKZNR7urIb7Z6c/qIm+EEhliUjGV+IMgduqhW4Ot4STSK3dbTko8d/EsWUDrLqK/mKJuMvFhQVeLX6rhwQFFET/nDPxKpEswIAFT6zEoSNpx8w+0owILfsx5IiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdNi/no0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so9840979a91.2;
        Wed, 22 Jan 2025 06:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737556502; x=1738161302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64B+pidoaRT7qHak7HsFnThjWHObSeU9GZTl0tBl8Mo=;
        b=UdNi/no0sa8d4URsG0yFHI5gRvxgE+I+CkQeTgn46Qj3fNQuue6AmXEyx3WSH43Jh+
         nCtdTNH3cXvkmOivFfKFbNnjvD0FxR25WZkh0rfQgp4UkWl9ScRz0M2igv6emv3IhI+K
         jTqRNhx2iaeRVRfvltnC8ETuctzEqPmbgXxyP05R/7iA5d106yFELAWhsRM64xizA0aK
         td75l+7fPmLP4Wu/lUAtW6M+SfRfRZbAInFpDA7ytGMj4cGOay4zIx2QWrUcdHCXLQ1E
         0qeE+g9sVoUJMVf8D9udXW/hBSZBRWBB1w7rZqjgcJT3tFo7tiuIK75pKC24CwnQflqt
         Zq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737556502; x=1738161302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64B+pidoaRT7qHak7HsFnThjWHObSeU9GZTl0tBl8Mo=;
        b=Q3bRZ2OvByUntgjThXv8FytKjKxon4sg/xfRABmCvualelArnJqsz/0qN1rwY0rV9a
         NbhFyFFvWsyAvhf1H/zowlzEoN3fqZavsBbVNZQb/7jbwtFGXICsGqIl5u81UD7INTRG
         b+sUYhA1vMrFdiUpX0WmjcB75Os6qphqTYmQ9JoftaWzP/ulgMsKSjXheA7d3yU3ktBh
         Tk/edWAXCgjjjUoETKCvyZ5+7Sc+pta/ChpXe0jhf2qBZY4kma1bEA9K40xfNJOErNqO
         ND1c9/Sh/lb+Q8uCdIHp84dkTGddt9rzpZxOErByQXrF68KFC58mWD41M+lq3oAp0vvJ
         ucXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAS+8Zduchp7ehYTRLee09PDNlYPbvbCyJzQ4BEx9eYQWoCFFjX14h5fC1HgLQO2enw8+KLY3InMHN@vger.kernel.org, AJvYcCUUbfFK+nVVYxAKNMOCebTkK2waFAsoy5MWvYJLLvfrvC9L5vYGl3/8pzKEzLIokhDfo3Kmso6ZYf/G3A==@vger.kernel.org, AJvYcCVM5jVh23mm5XeZmYF0i6VTlHrBhfUgnpnLLfHkw7ldMoRqYGrGbLS6tFsD8U70Y06aPrZH1N9cgJdbDxEq@vger.kernel.org, AJvYcCWHeRSNszuGeuWHxbOc3F+kG32P0ckdfdJMI+Y4rn/9z9TUuCOKZbEo6gbe7rwgmbAyvzMqK7UYDAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzptx/xITHw8eHwaAVQfutOrULQKJw1I+VzaLx43QFznhNyYOsn
	+oQvWvb81f9jbn+81hW1CluNeqLDhM/46AjmyGY5TYsLiw4OO1vZ
X-Gm-Gg: ASbGncvMHdwNQjbgucwUBDsOzM1IC6dUqZ5gwMzl8nlcUumsnCGOZq7LLwFXU9aCNKi
	QLFXxlOC6rV0X54k3t0Qyc7Wb5w1yiW+2QUltlVbepEejLQ5+n77x4K4Gomcxitl0AbpVUu922P
	NpMx7W2Lq1CBnny/sTPjWx1cAxCdtmN7TslK3OaNIEBiBe2mIHEFPXEgS9BGE7AsYsr/JkwCBk8
	M/1pBFXOHgRcGaAI3QziYT/CAayYMHIcBTtufxmpm7dF1l5mWzHyUwU23KSs92z96AEog==
X-Google-Smtp-Source: AGHT+IHye6tnI6e9pHe4b35uSdIBEZ3t5Qm38grITS0mOAk2fG2/svwd3ROxg41Sd4Zw25vu2TOk4Q==
X-Received: by 2002:a17:90b:4ed0:b0:2f4:434d:c7f0 with SMTP id 98e67ed59e1d1-2f782c71cb4mr36319616a91.12.1737556501607;
        Wed, 22 Jan 2025 06:35:01 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6ad9109sm1868233a91.46.2025.01.22.06.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 06:35:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 9C8984209F8C; Wed, 22 Jan 2025 21:34:58 +0700 (WIB)
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
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/3] Tree-wide nreferenced footnotes fixes
Date: Wed, 22 Jan 2025 21:34:53 +0700
Message-ID: <20250122143456.68867-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185; i=bagasdotme@gmail.com; h=from:subject; bh=m8lx9id+N8G1oRBTTUZ2U5IdfXbQFt9T4fAAHi4VtRk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOkTGfUtAn73HKm8PG+FUOHGHwffNBXcflImPOVi/cEPK mz2Aa8+dZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAi1nMY/sdI27HO3/xlhdaD d/3xny5t+73myCeWqPYX9nkGaTMeftBmZFggON10bRC/O9tibpErhW8kzqRc4mgKyX3Rcq5Mct6 dw+wA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx 8.1 introduces improved unrefenced footnotes detector. The changelog
[1] reads:

    - #12730: The UnreferencedFootnotesDetector transform has been improved
      to more consistently detect unreferenced footnotes. Note, the priority
      of the transform has been changed from 200 to 622, so that it now runs
      after the docutils Footnotes resolution transform. Patch by Chris Sewell.

As a result, a few new warnings are smoked out in the whole tree, that
are previously unnoticed in earlier Sphinx versions. Let's squash these
warnings.

[1]: https://lore.kernel.org/linux-next/07507296-a37b-4543-97cb-0560ef7fb7b8@gmail.com/

Bagas Sanjaya (3):
  media: ipu3.rst: Prune unreferenced footnotes
  Documentation: ublk: Drop Stefan Hajnoczi's message footnote
  docs: power: Fix footnote reference for Toshiba Satellite P10-554

 Documentation/admin-guide/media/ipu3.rst | 7 ++-----
 Documentation/block/ublk.rst             | 2 --
 Documentation/power/video.rst            | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)


base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
-- 
An old man doll... just what I always wanted! - Clara


