Return-Path: <linux-pm+bounces-40416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F979D011B1
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 06:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFBCD301413B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 05:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6837B314D2A;
	Thu,  8 Jan 2026 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="E/oiVAMd"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E4314D06;
	Thu,  8 Jan 2026 05:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850358; cv=none; b=XSTqIlsYKR76jvg4xwBuVGZWH0zgRIlMVUbkMU9e/vddPnYCLsly3eLUcnf967kkhsbmejUnKR6ab98crNj7AGuKZGxwkbyjY0d2UJ0Mov8zoyePb606sR0yO3IzKRzkC0IIjEQUsE4CritvxftGWzSyysVaAkNbIqhPHH72Z4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850358; c=relaxed/simple;
	bh=/sry4RXnqhhzWzGDHtngiH6f3rQpnXqg5STFKGz6qAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H4jc16MII9K2IUSosHpSPM94VV/KWuqSTfCME6fWEbhBnhfcIc2of+xZwuNUxu7euGrVj9khVoEOjs7cR3+Ko1FO51xuRft0CyChaRIIetAoQQKlpmerpFWcL1cKIHq4wlzzKZtZ8HOOsu03u2CC6H80QxIn4OdIzhyPLO2jJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=E/oiVAMd; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rsjADZuy3/dvrqWWWeQRCBgAwbSCdq7aKeqqHRcyF0M=; b=E/oiVAMdleEdQiBDp0ADCfa1Yq
	mBMH1LSWwvo6YMPdGH2dN8fnmY/15DsYhxDyJ2rL47/h9fyKXJTqtFVhszO8NkN/13DgErqM+z53f
	XhNZHi5etvLG60WrM6nuww1As0HtVLyT3jaXu44rvfhMKgXfGPg1jiNbAFZXTGO2ANP5r3J7TL6Yo
	bR9BFwLB4a/GyTPeSDdue+BcQao7lUSRA8pbpeeuQlQR6i+Za1NWyU8YbMvR7fmF0z7I5IIQwtPaT
	m2QLraeNzxb6UB8KiWEqObMPEbIE5wnd5f5sbj9LwJ8DDR+0FDMlao2RwE/+aKyVQeASNnBBgi7tU
	IFfIYLhQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdidA-002qDF-J0; Thu, 08 Jan 2026 06:32:21 +0100
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
Subject: [PATCH v2 for 6.19 0/4] Revise the EM YNL spec to be clearer
Date: Thu,  8 Jan 2026 14:32:08 +0900
Message-ID: <20260108053212.642478-1-changwoo@igalia.com>
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

ChangeLog v1 -> v2:
- Remove perf-domains in the YNL spec, as do and dump of get-perf-domains
  share the reply format using perf-domain-attrs (4/4).
- Add example outputs of get-perf-domains and get-perf-table for ease of
  understanding (cover letter).

This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for example,
with the following commands:

  $> tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/dev-energymodel.yaml \
     --dump get-perf-domains

    > [{'cpus': [0, 1],                                                                     
    >   'flags': {'perf-domain-skip-inefficiencies', 'perf-domain-microwatts'},             
    >   'perf-domain-id': 0},                                                               
    >  {'cpus': [2, 3, 4], 'flags': {'perf-domain-microwatts'}, 'perf-domain-id': 1},       
    >  {'cpus': [5, 6], 'flags': {'perf-domain-microwatts'}, 'perf-domain-id': 2},          
    >  {'cpus': [7], 'flags': {'perf-domain-microwatts'}, 'perf-domain-id': 3}] 

  $> tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/dev-energymodel.yaml \
     --do get-perf-domains --json '{"perf-domain-id": 0}'

    > {'cpus': [0, 1],                                                                    
    >  'flags': {'perf-domain-skip-inefficiencies', 'perf-domain-microwatts'},            
    >  'perf-domain-id': 0}

  $> tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/dev-energymodel.yaml \
     --do get-perf-table --json '{"perf-domain-id": 0}'

    > {'perf-domain-id': 0,                                                               
    >  'perf-state': [{'cost': 2984,                                                      
    >                  'flags': {'perf-state-inefficient'},                               
    >                  'frequency': 364800,                                               
    >                  'performance': 34,                                                 
    >                  'power': 10147},                
    >                                                                                                    
    >                 ...
    >                 
    >                 {'cost': 6982,
    >                  'flags': set(),
    >                  'frequency': 2265600,
    >                  'performance': 216,
    >                  'power': 150816}]}

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

 .../netlink/specs/dev-energymodel.yaml        | 175 ++++++++++++++
 Documentation/netlink/specs/em.yaml           | 113 ----------
 MAINTAINERS                                   |   8 +-
 include/uapi/linux/dev_energymodel.h          |  82 +++++++
 include/uapi/linux/energy_model.h             |  63 ------
 kernel/power/em_netlink.c                     | 213 ++++++++++++------
 kernel/power/em_netlink_autogen.c             |  58 +++--
 kernel/power/em_netlink_autogen.h             |  22 +-
 8 files changed, 449 insertions(+), 285 deletions(-)
 create mode 100644 Documentation/netlink/specs/dev-energymodel.yaml
 delete mode 100644 Documentation/netlink/specs/em.yaml
 create mode 100644 include/uapi/linux/dev_energymodel.h
 delete mode 100644 include/uapi/linux/energy_model.h

-- 
2.52.0


