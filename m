Return-Path: <linux-pm+bounces-39924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD29CDD44A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Dec 2025 05:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C75F3010FDF
	for <lists+linux-pm@lfdr.de>; Thu, 25 Dec 2025 04:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0F1A3179;
	Thu, 25 Dec 2025 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hG1dlgS6"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F1137932;
	Thu, 25 Dec 2025 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766635301; cv=none; b=aLEf6WAmmncPTGwSndH9fl+vzIo8sP+XjDPDda/4+JE75ILZ+VRprSSyV5Nvxu4xqPKufECtVVra62yneerHJiNKiK3pfUCZaIGRZXVhjDJ0GHftyJ1vBgAhkJLAaYODbbCF4caAYVSxQLP4rgxy8X17D0YEAtIROLHoWqbB3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766635301; c=relaxed/simple;
	bh=sskXjqalJpXJeJYI3H3wRotpMuS3CPVcUt6AgPaOJxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kqiLw5s+m3jqvNsg/WJ56bTQIg7/sDYUIgOSf+tYo7hbCoXvFZkqvUglJtRUidg5ROAqTqvEtA6MNWAu04i5N/4nF+HZkDBui5j2L1h+qrUP/j5honDlDtuVYon6mjohvzfjiMc+5MXbvIVhKxUsSVvgMpZFJymFvgDduTybkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hG1dlgS6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1ltEyGKlKJr9s0HLrCnwNtlQKqlrQbmPClgKAVREPzQ=; b=hG1dlgS6mx4DLZ4vDtwtBEkc81
	6aZdlMbRIV3fWEoB8njwdWDrMD/gcfenGrTftXnvUbNZYql0iy8EOhZdAQQUCrW4agW/k/vxPEB8/
	XDAe+ChZTAf7f0YNLjVNrpmKBxGiwPUEzN9PRQHVktlu/2S01rs01EDCABHrgb20CJu6kYKbAvrdW
	CKDWcrH6/ihzLykNzo+x6z/6qWQckTtcokNw5Pb7/K2xZ79eFDt3bQJCStId08Y4xTZs7E9xtZxow
	oKcR8s4/JdOc5Y/m+0WOW+6lsIoHjlrL0yKA14NfYKRcSYl+0wY1gxgBo9+EUacFFeyVGwgsXWdxb
	KLFklNvw==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vYcXI-00GLkw-3d; Thu, 25 Dec 2025 05:01:13 +0100
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH for 6.19 0/4] Revise the EM YNL spec to be clearer
Date: Thu, 25 Dec 2025 13:01:00 +0900
Message-ID: <20251225040104.982704-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set addresses all the concerns raised at [1] to make the EM YNL spec
clearer. It includes the following changes:

- Fix the lint errors (1/4). 
- Rename em.yaml to dev-energymodel.yaml (2/4).  “dev-energymodel” was used
  instead of “device-energy-model”, which was originally proposed [2], because
  the netlink protocol name cannot exceed GENL_NAMSIZ(16). In addition, docs
  strings and flags attributes were added.
- Change cpus' type from string to u64 array of CPU ids (3/4).
- Add dump to get-perf-domains in the EM YNL spec (4/4). A user can fetch
  either information about a specific performance domain with do or information
  about all performance domains with dump. 

This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for example,
with the following commands:

  $> tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/dev-energymodel.yaml \
     --dump get-perf-domains
  $> tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/dev-energymodel.yaml \
     --do get-perf-domains --json '{"perf-domain-id": 0}'
  $> tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/dev-energymodel.yaml \
     --do get-perf-table --json '{"perf-domain-id": 0}'
  $> tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/dev-energymodel.yaml \
     --subscribe event  --sleep 10

[1] https://lore.kernel.org/lkml/CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CAJZ5v0gpYQwC=1piaX-PNoyeoYJ7uw=DtAGdTVEXAsi4bnSdbA@mail.gmail.com/

Changwoo Min (4):
  PM: EM: Fix yamllint warnings in the EM YNL spec
  PM: EM: Rename em.yaml to dev-energymodel.yaml
  PM: EM: Change cpus' type from string to u64 array in the EM YNL spec
  PM: EM: Add dump to get-perf-domains in the EM YNL spec

 .../netlink/specs/dev-energymodel.yaml        | 188 ++++++++++++++++
 Documentation/netlink/specs/em.yaml           | 113 ----------
 MAINTAINERS                                   |   8 +-
 include/uapi/linux/dev_energymodel.h          |  90 ++++++++
 include/uapi/linux/energy_model.h             |  63 ------
 kernel/power/em_netlink.c                     | 207 ++++++++++++------
 kernel/power/em_netlink_autogen.c             |  58 +++--
 kernel/power/em_netlink_autogen.h             |  22 +-
 8 files changed, 472 insertions(+), 277 deletions(-)
 create mode 100644 Documentation/netlink/specs/dev-energymodel.yaml
 delete mode 100644 Documentation/netlink/specs/em.yaml
 create mode 100644 include/uapi/linux/dev_energymodel.h
 delete mode 100644 include/uapi/linux/energy_model.h

-- 
2.52.0


