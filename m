Return-Path: <linux-pm+bounces-987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373B280F174
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 16:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671A01C2092F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468E76DCE;
	Tue, 12 Dec 2023 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jQC4uwFC"
X-Original-To: linux-pm@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BE3399;
	Tue, 12 Dec 2023 07:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IpOE+
	yOb38TYE+chSPo0EQBJbqg59f0ue3S/ECPEw9U=; b=jQC4uwFCJwe0bL3XkN72E
	ziI6IK1+bbbz9d9kzqM7EMZrtWb0qwEQegRnG/LyiDekJLieLdWotkVm6qsTjYwZ
	BGuIhi+yjmMHQ97Bim+CEyMCicKhGflFEE1158o+dltNDZAuAsBU/cw1IETmMdu7
	dPko4gHA5W+Hz7aS4K+VuY=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
	by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3n0KHgHhly6dkBA--.31946S2;
	Tue, 12 Dec 2023 23:47:20 +0800 (CST)
From: chenguanxi11234@163.com
To: rafael@kernel.org
Cc: chen.haonan2@zte.com.cn,
	chenguanxi11234@163.com,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@ucw.cz
Subject: Re: [PATCH linux-next] kernel/power: Use kmap_local_page() in snapshot.c
Date: Tue, 12 Dec 2023 23:47:19 +0800
Message-Id: <20231212154719.2667-1-chenguanxi11234@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0gLswRMBR1-b_TQTau7KMpuBbR5hYJyat6pMOD5zYSi7Q@mail.gmail.com>
References: <CAJZ5v0gLswRMBR1-b_TQTau7KMpuBbR5hYJyat6pMOD5zYSi7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n0KHgHhly6dkBA--.31946S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RG38nDUUUU
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/1tbiDglE+mSAZJK76AAAs4

Thanks for your explanation, I have modified my description 
information and submitted the updated version of patch.


