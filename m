Return-Path: <linux-pm+bounces-15311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6759D9943E9
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909001C235FD
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 09:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283E4197A65;
	Tue,  8 Oct 2024 09:14:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169ED192D9E
	for <linux-pm@vger.kernel.org>; Tue,  8 Oct 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378879; cv=none; b=RS1HJb2JoqRn6eUE+iYp3wdI0WA+1hgVlkaY32aNFJjhGiskMtRiLf3fksoLoWnptg7v4gEv6VaFR5AQ98Sci3U6/KNaarxdxyO8PH0dRHKShp2ifDYPd48zPI0vzo7c74HPSXoavkuEM8SOgr/3xZ4m9ZWn3B3Aib9Qjqz4Jrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378879; c=relaxed/simple;
	bh=aZ7a6do1I9lRvki6g0ztNEBHyJ+s91TElHWBfDtQ2h4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QXc8IRwYlS/i/F3DaK0Qny0nQVgkluio51KsHBLZvEqxXZ0tq1ycjNZZ+N6NmChyXZZOoyH5iE9QU1N0umvUsQgR1l18avnFWo+o4tubvlzD1ifqnFIS4+TLRkOhBBPNcUn+ukuBT7C6CEEuuLUawda93TBdMZ5QgsHnePDTl7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:af78:ce2e:2b4b:9f2a])
	by baptiste.telenet-ops.be with cmsmtp
	id MlET2D00H0Eqs9l01lET5l; Tue, 08 Oct 2024 11:14:28 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sy6IL-003RYK-1y;
	Tue, 08 Oct 2024 11:14:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sy6IV-00D2DB-GN;
	Tue, 08 Oct 2024 11:14:27 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP tables
Date: Tue,  8 Oct 2024 11:14:19 +0200
Message-Id: <cover.1728377971.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

When CONFIG_ENERGY_MODEL=y, an error is printed on RZ/G2E and R-Car E3:

    cpu cpu0: EM: invalid perf. state: -22

This happens because the Operating Points Parameters tables do not list
voltages, as they are all identical.  Previously, it was assumed they
were optional, and unused, when none of the CPU nodes is tied to a
regulator using the "cpu-supply" property.  This assumption turned out
to be incorrect, causing the reported error message.

This RFC patch series fixes this by adding the missing voltages.

Note that the Energy Model calculates energy efficiency by dividing the
(estimated) CPU power consumption by CPU core clock frequency.  When all
voltages have the same value, the former is proportional to clock
frequency, and energy efficiency becomes a constant.  Hence all
operating points are considered to have the same efficiency, and the
Energy Model always picks the one with the highest clock rate (see also
[1]).

Alternatively, the Energy Model could be changed to silently ignore OPP
tables with missing frequencies.  IMHO this is not an unusual case.

Which approach should be taken?
Thanks for your comments!

[1] "PM: EM: Question Potential Issue with EM and OPP Table in cpufreq
     ondemand Governor"
    https://lore.kernel.org/all/a2ca883e-122e-43a1-b377-c43956b5b3be@arm.com

Geert Uytterhoeven (2):
  arm64: dts: renesas: r8a774c0: Re-add voltages to OPP table
  arm64: dts: renesas: r8a77990: Re-add voltages to OPP table

 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 3 +++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

