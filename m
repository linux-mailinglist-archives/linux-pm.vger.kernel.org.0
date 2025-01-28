Return-Path: <linux-pm+bounces-20987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B6A2021F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 01:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242841659B6
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 00:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFEB1F941;
	Tue, 28 Jan 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzEmEmmD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F89EAF1;
	Tue, 28 Jan 2025 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022797; cv=none; b=poNMj2xnf9uVqok9GGfXts6eOVerkasCSFJGdv9AUi9qyreOBtMsDf7QhEIhHKGAIHAn/Gq2Dy6c6qx61mCMyYhoFVkgIp0i/xzwaYVG4wAS6Ctg3Tb2AlFLxYlMzgnAOcTeuqfPb+WAr+52DgkAiMCfztGt+i7ZG0KkVUk/COA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022797; c=relaxed/simple;
	bh=VcPpgtY3VQCVYahI46jBKsD0IQlmSoQRt+Yw3exCthU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcxG0UkFHAx5fFHx3tUEl9B5xRXfmF8rRjZJ0Q4IdQb1xLtA7V1guLOzyGj9lWNEZ+VcdqKeuHu4SDTIOS3wJ0e1MiWidcYkOukHPSeZgfoXdjebNwCpbLSv2trOSM7sLqAHqT90pyjNwyCEDM4cXtKoDgVg0ZddlQHUdgfCgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzEmEmmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE66C4CEE9;
	Tue, 28 Jan 2025 00:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738022795;
	bh=VcPpgtY3VQCVYahI46jBKsD0IQlmSoQRt+Yw3exCthU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pzEmEmmDia/8h9o9vspt9axQUlQqbUbHcWZiA1nEKYZ6OFf67FyzD4eYPZ7fEUWR4
	 W/BtG+ds63lWVpcqjD8JHtKjQGfHVwDw0ARcGCyBg4zIpbfM6F+/3TRbN5WsS27jHi
	 2OOKb3Qoiypa5MsNd55nzei5d9d3VKRvKOFef0HHfDhAEEgyl5FKH02CpricPoNYLF
	 qBK+Bc0WEGj7Cl8nXHpqnWlCDGXIQ4TXWEduOQzb4k1mkthwM6rc3DrZIPgbVEL3PU
	 9FcNsM23N3TWSBA7NrjWnD9c1rMb2rRm8oDefzcsTO6YQACFimeHzaeuDyNNU1lVgn
	 AZpIPY7ofcpxA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tcZ7h-0000000DRKR-2TDa;
	Tue, 28 Jan 2025 01:06:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Rafael J. Wysocki" <mchehab+huawei@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [RFC v2 01/38] docs: power: video.rst: fix a footnote reference
Date: Tue, 28 Jan 2025 01:05:50 +0100
Message-ID: <fd7d13339882999a2c53f0e85024c23ee955e0c6.1738020236.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738020236.git.mchehab+huawei@kernel.org>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Footnotes require an space (or a "\ ") before them, as otherwise
Sphinx/Docutils won't understand it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/power/video.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/video.rst b/Documentation/power/video.rst
index 337a2ba9f32f..8ab2458d1304 100644
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
2.48.1


