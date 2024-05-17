Return-Path: <linux-pm+bounces-7950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432408C8C3B
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663911C21100
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27DD534;
	Fri, 17 May 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igM+4s0u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8836CA23;
	Fri, 17 May 2024 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715970688; cv=none; b=nFlepOPhQCYsRDQ6yNmegX0l7KNdYEMrpwKCj9kR+7z6OEkuWiadO6CYhz1XmCgWJArh9f8ITMdf58njh4zEcjZhCDQ9Hj39x+wRjPDmueQGOSzmlhM1AmhZohSsOMoGZg/vLgvpOvj2w6SheRmgkVwvspr3k0hk/oPzHLOPfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715970688; c=relaxed/simple;
	bh=5zJvxrA6oZHOzqtbgFUtTLQcJmxb28RuayzYscqRbkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiwCVnZng7V3n/nscL1iNOz2sjoqB8Vy1wgbnA50sFIoYhYiYJhSyjeSLBjZjC/WfupujALSnbpkw/JABc/YJB0RBfqOAzzcSILl94Ygyj7cRDM3xr+0/BVBhGZP5VvwlG6r8WcelK/19FbVDOry5rfwWRDgq0xCX0Ls6VjNDds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igM+4s0u; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715970687; x=1747506687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5zJvxrA6oZHOzqtbgFUtTLQcJmxb28RuayzYscqRbkY=;
  b=igM+4s0uJFcbYV5e0SxM7zO3rzCA394bdlmnPLjsa29wR3PSqgoppxSO
   g9tOTs2M6ZWCeIvKBwKgs2QwH+aZMgiqO5OcxnEw4pry9fG/QTyAyUrzC
   EnBlAMyEfNLZDs505R3zFyc4oP5BRwq0lXJgpvsyStM6nzmnz07So408R
   JY87RUKOA52DCuNo4G5vuYCQKlu7aCZkYlpHIgB+s/F2fGC9buM+5kUlZ
   mphccdDvaSaDpZUH+YX9dUEK7LfKmel14o9/vtTszKy/VDvpRhNC1+Dg5
   nNHQ4Rf6H+DH9D2X19js88SOeGwA6DTJnKqXdE9iiTjwQhUbW4JswIy98
   Q==;
X-CSE-ConnectionGUID: aUPRLLLeQMGRLjaDZqRzug==
X-CSE-MsgGUID: 4WNjlNxKRu2gac/KWPwqdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12277953"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12277953"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 11:31:26 -0700
X-CSE-ConnectionGUID: f3hF2My7SqaGqKzpxbzs2A==
X-CSE-MsgGUID: +FDDz3DTSIyTsq8o5Kvr/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31896160"
Received: from snouri-mobl2.amr.corp.intel.com (HELO desk) ([10.212.163.129])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 11:31:25 -0700
Date: Fri, 17 May 2024 11:31:18 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
Message-ID: <20240517183118.tcxncoaec2e5hqkv@desk>
References: <878r0djxgc.fsf@kernel.org>
 <874jb0jzx5.fsf@kernel.org>
 <feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com>
 <20240515072231.z3wlyoblyc34ldmr@desk>
 <529C9374-DA6F-49C8-9B32-91741800F8E4@alien8.de>
 <20240515162747.6shmaoelc4mt7nro@desk>
 <878r0bhvjq.fsf@kernel.org>
 <20240516070315.swz2golcrfp3uvfd@desk>
 <20240516142513.qqy7wbmja5frizuj@desk>
 <87a5kofi96.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5kofi96.fsf@kernel.org>

On Fri, May 17, 2024 at 08:41:41PM +0300, Kalle Valo wrote:
> There is no special workload when I reproduce the bug. This NUC box is
> one of our test setups which I use to test ath11k and ath12k wireless
> drivers, but when I'm debugging this suspend issue none of the wireless
> drivers are not even loaded. I don't normally have a display connected
> to the box but I do run netconsole, although I just verified that I see
> the bug if I remove netconsole configuration from cmdline.
> 
> The distro is Ubuntu 20.04.6 LTS. Oh, but I do have installed a WCN6855
> PCI module to the box so that I can test ath11k. That can of course make
> a difference. And maybe also BIOS settings?
> 
> I think is easiest if I try get more info about with my box first, it
> might be quite challenging for you to reproduce it.

When I enable ftrace I see similar behavior where the system fails to
suspend. I am not fully sure if I have reproduced the same issue, but the
symptoms do look similar. The test setup is undergoing some maintenance by
the lab people, so I my debugging is paused for now. I will resume
debugging once I get the setup back.

Below is how I reproduced it fairly quickly:

# trace-cmd start -p function -e power -e msr
# cat /sys/kernel/debug/tracing/trace_pipe > trace.log &
# for i in {1..400}; do echo "rtcwake test $i" > /dev/kmsg; rtcwake -m mem -s 10; sleep 10; done

Cmdline: BOOT_IMAGE=/boot/vmlinuz-6.9.0-rc7-test+ root=UUID=77593d83-f3ee-4a03-8f8d-12344ec878ec ro console=tty1 console=ttyS0 no_console_suspend ignore_loglevel sysrq_always_enabled systemd.unit=multi-user.target

Last kernel logs:

[...]
rtcwake test 1
PM: suspend entry (deep)
Filesystems sync: 0.000 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.001 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
e1000e: EEE TX LPI TIMER: 00000011
sd 2:0:0:0: [sda] Synchronizing SCSI cache
ata3.00: Entering standby power mode
ACPI: EC: interrupt blocked
ACPI: PM: Preparing to enter system sleep state S3
ACPI: EC: event blocked
ACPI: EC: EC stopped
ACPI: PM: Saving platform NVS memory
Disabling non-boot CPUs ...
smpboot: CPU 1 is now offline
smpboot: CPU 2 is now offline
smpboot: CPU 3 is now offline
smpboot: CPU 4 is now offline
smpboot: CPU 5 is now offline
smpboot: CPU 6 is now offline
smpboot: CPU 7 is now offline
ACPI: PM: Low-level resume complete
ACPI: EC: EC started
ACPI: PM: Restoring platform NVS memory
Enabling non-boot CPUs ...
smpboot: Booting Node 0 Processor 1 APIC 0x2
CPU1 is up
smpboot: Booting Node 0 Processor 2 APIC 0x4
CPU2 is up
smpboot: Booting Node 0 Processor 3 APIC 0x6
CPU3 is up
smpboot: Booting Node 0 Processor 4 APIC 0x1
CPU4 is up
smpboot: Booting Node 0 Processor 5 APIC 0x3
CPU5 is up
smpboot: Booting Node 0 Processor 6 APIC 0x5
CPU6 is up
smpboot: Booting Node 0 Processor 7 APIC 0x7
CPU7 is up
ACPI: PM: Waking up from system sleep state S3
ACPI: button: The lid device is not compliant to SW_LID.
ACPI: EC: interrupt unblocked
sunrisepoint-pinctrl INT345D:00: restored pin 103 padcfg0 0x000000
sunrisepoint-pinctrl INT345D:00: restored pin 103 padcfg1 0x00001f
sunrisepoint-pinctrl INT345D:00: restored pin 118 padcfg0 0x000000
sunrisepoint-pinctrl INT345D:00: restored pin 118 padcfg1 0x00002e
ACPI: EC: event unblocked
i915 0000:00:02.0: [drm] [ENCODER:94:DDI B/PHY B] is disabled/in DSI mode with an ungated DDI clock, gate it
i915 0000:00:02.0: [drm] [ENCODER:111:DDI C/PHY C] is disabled/in DSI mode with an ungated DDI clock, gate it
i915 0000:00:02.0: [drm] [ENCODER:115:DDI D/PHY D] is disabled/in DSI mode with an ungated DDI clock, gate it
serial 00:07: activated
ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata4: SATA link down (SStatus 4 SControl 300)
sd 2:0:0:0: [sda] Starting disk
ata3.00: configured for UDMA/133
mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops)
OOM killer enabled.
Restarting tasks ... done.
random: crng reseeded on system resumption
atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
PM: suspend exit
atkbd serio0: Failed to enable keyboard on isa0060/serio0
e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
rtcwake test 2

