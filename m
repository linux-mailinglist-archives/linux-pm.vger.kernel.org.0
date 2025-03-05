Return-Path: <linux-pm+bounces-23524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49577A50D27
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 22:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82466171D3C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 21:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6292571C9;
	Wed,  5 Mar 2025 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="m7m25k+3"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88B253330;
	Wed,  5 Mar 2025 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209215; cv=none; b=dQ4tn1wr+TnI5BQdGZhDwISitKw970spEo9EBfskMg8sFKLakcPLa5rgCqefLcpkTMraYfinaZ0wO0hJE8/RmdjBM8uxokY335ik8uG+Mh7h+8xc/uGJRFtkL+CD9AY1QPs0AAgABONF1n0nzzeF6fUyzOS7SyR0CEqa/KxTIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209215; c=relaxed/simple;
	bh=vXmUPa9fVIc434p+E8O9ucq+XRNxzAIBnrk/gGTgStI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W4SVKHnQQC/ZjvDmTejygw3F73J5TsTk6BRWg+yCqz4sJ4whtxf5TVl0ZJriEqPpoPsczsYlidsAXY3xVcFlCY+cKxAQlPCykHnQgQ34Mc74GKqQtJe8WLf2PwtBdrd2nYIF1PBrVBEBTkfu+HIM+8eKoTCjvdZjTvo3/jopFcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=m7m25k+3; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 9724e2181c2ed1d3; Wed, 5 Mar 2025 22:13:26 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B01529A0CE1;
	Wed,  5 Mar 2025 22:13:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741209206;
	bh=vXmUPa9fVIc434p+E8O9ucq+XRNxzAIBnrk/gGTgStI=;
	h=From:Subject:Date;
	b=m7m25k+3pJOejiuSF4cyfe3T1bv1MgC2BBB62suJ0hyNPaLaTsR88YPpITyg9Ujdl
	 8uE3JahrdAAB2vGIS0CAI0MlyYIEARJp3lKG61qBr4coAsK8yVfKH8sgWjOamUD0F3
	 VFckf1S4X9beHI/4DvDUpPWevbMMfdB0JjXUfaMTMJ8xO4mDXkOXvDFYDJKogPBXtE
	 1WInlW5sb0KXPZ7PgHbnidDZyB0/vPWtXjx+mMIv2WBusRAJyBNSQrq7lKry/44lEL
	 C3PfXxnpFBsD/xSjsAT0LS5y/hE9HF/1mYG8EGW/nfRQWg5nvIzYwiDSIMMl+wfN34
	 Saw5ddxO/pMGA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [PATCH v1 0/3] PM: EM: API cleanups and elimination of __rcu-related sparse
 warnings
Date: Wed, 05 Mar 2025 22:06:11 +0100
Message-ID: <5880743.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnhhnsegrrhhmrdgtohhmpdhrtghpthhtoheprhhitggrrhguohdrnhgvrhhiqdgtrghluggvrhhonheslhhinhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

Patch [1/3] adds const to the cp and cpus parameters of
em_dev_register_perf_domain().

Patch [2/3] unexports functions that are only used locally in
the Energy Model code.

Patch [3/3] eliminates sparse warnings related to __rcu usage.

Please refer to the individual patch changelogs for details.

Thanks!




