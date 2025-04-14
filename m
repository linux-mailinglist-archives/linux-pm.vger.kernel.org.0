Return-Path: <linux-pm+bounces-25377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE567A88720
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639BF1885FE1
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0D92741C2;
	Mon, 14 Apr 2025 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="iGrEy5To"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38125229C;
	Mon, 14 Apr 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643956; cv=none; b=kLdkOUTDFu22lck/dtHobXqeOnCb9I2jdkImcqBSPDZg2qvYZzwdUa4rVYS7Ev+y2Uxds3Jnr8hJyP0ieq7L0VPGmAddgC2kzpGS94stcg0rd/OLBXl63JvNR9XLrjgEbVCM3KzK0EPXJdfvnlhFiBhYOvJ21WedJrZuWHVraes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643956; c=relaxed/simple;
	bh=W5YOQtXedZ5LjIHnkYlu8DTaYYS962zrtA6Gi1Nsypg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQmBVWeBsIeNTPeb86yfo1zt/wdtQPcsuS1nkXr8xZndB5pX3OXSqzk+A6497qFI7+mv/NsvUjzpPcixFQFDRCqBulGY12uTAadjYUVRb0rQem1TbsIZU+fN4ErBehONSMw+A9DCgQULYUXoERt43NclVoBaGm+uM1W8nXWT+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=iGrEy5To; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E1C74662598;
	Mon, 14 Apr 2025 17:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744643945;
	bh=W5YOQtXedZ5LjIHnkYlu8DTaYYS962zrtA6Gi1Nsypg=;
	h=From:Subject:Date;
	b=iGrEy5Toj8WPBIrSXoxS4Dm4ijPuzDgrmOIs1rughbdguIoAFjyQMw9P2CSU/N8md
	 nldU/OpEpWYTBnhMquOEyaoo/+vw9/oPBYUzbZrrgCKh0+9jOlHJN/cPEmcHWqOEgL
	 8RCtOq1/nTgA+giSSGSZgUBeRG/xRIVk9r4OQaiEMlcmwAYnDs4W05zAZ3rcQwuzxZ
	 4fbpoKOz2iVQ22VRcEUOLZ/ZYHFNwF+vF8In5qQjSe2DqskAm3N/m+6PL2XAc//zi0
	 0xxoubTQDbbwQ+VMcmHgETT1ldjHlEMPFI6R8hW/UkYr1yE/VZLtMCJks+V0NXYJHn
	 ZD+EAZ24pzoOA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject:
 Re: [PATCH] cpufreq: intel_pstate: Use raw_smp_processor_id() in
 hwp_get_cpu_scaling()
Date: Mon, 14 Apr 2025 17:19:04 +0200
Message-ID: <12659608.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <b7b0b3f98f8fad9cc9559e1c4ce832387c520d7a.camel@linux.intel.com>
References:
 <20250412103434.5321-1-xry111@xry111.site>
 <b7b0b3f98f8fad9cc9559e1c4ce832387c520d7a.camel@linux.intel.com>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigrhihudduudesgihrhiduuddurdhsihhtvgdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrfigrnhdrkhhumhgrrhdrghhuphhtrgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

On Sunday, April 13, 2025 4:44:56 PM CEST srinivas pandruvada wrote:
> On Sat, 2025-04-12 at 18:34 +0800, Xi Ruoyao wrote:
> > Use raw_smp_processor_id() instead of plain smp_processor_id() in
> > hwp_get_cpu_scaling(), otherwise we get some errors on a Lenovo
> > Thinkpad
> > T14P Gen 2:
> > 
> >     BUG: using smp_processor_id() in preemptible [00000000] code:
> > swapper/0/1
> >     caller is hwp_get_cpu_scaling+0x7f/0xc0
> > 
> > Fixes: b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to get
> > cpu-type")
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

It's still broken after this patch though because the function should
use the cpu_data() of the target CPU and not of the CPU running the code.

The patch below should fix it.

===
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] cpufreq: intel_pstate: Fix hwp_get_cpu_scaling()

Commit b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to get
cpu-type") introduced two issues into hwp_get_cpu_scaling().  First,
it made that function use the CPU type of the CPU running the code
even though the target CPU is passed as the argument to it and second,
it used smp_processor_id() for that even though hwp_get_cpu_scaling()
runs in preemptible context.

Fix both of these problems by simply passing "cpu" to cpu_data().

Fixes: b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to get cpu-type")
Link: https://lore.kernel.org/linux-pm/20250412103434.5321-1-xry111@xry111.site/
Reported-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2336,7 +2336,7 @@
 static int hwp_get_cpu_scaling(int cpu)
 {
 	if (hybrid_scaling_factor) {
-		struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+		struct cpuinfo_x86 *c = &cpu_data(cpu);
 		u8 cpu_type = c->topo.intel_type;
 
 		/*




