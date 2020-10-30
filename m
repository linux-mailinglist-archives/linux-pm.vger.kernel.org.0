Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954EF2A081A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 15:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgJ3OjU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 30 Oct 2020 10:39:20 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38773 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3OjT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 10:39:19 -0400
Received: by mail-oi1-f173.google.com with SMTP id 9so6857456oir.5;
        Fri, 30 Oct 2020 07:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CQ4kOqMNBFKb/sf1rrFWyvX7qCQgrBczWFfGxdlwTNI=;
        b=Eu7C8SRO5tWmstwrwiQABDZL6RL2pKrhPeM8g3rqPxKwZqO/X8fNlPzK6RxEqqw/p+
         nrNblPyYHyLy7NY57dJi6YEFCU4qy41odcV4J6Dlx6dX8ThpTXAMBja3zWkHx4t+Rf7U
         MavTimqhoVDEEQBz2ayonND6K9P4bkcw3a79cUq4QMTixvw4q6oJwRoY+uLm6wJer8zC
         MDzMGfPRQvALa/Dbj+p9tyKKcCzhCJHrGznoxzzAHiJC4TX50N2DqN+tgzUat8tvWZJk
         aLlt5BUvCFvvVb+pVGUpfzpLVXjuuWJFg0UylnGonmqHaToOYVmxeHxctM/VAhBy2qth
         KrLA==
X-Gm-Message-State: AOAM5301o8XpGF28iQfwus1Ct3fdM63GJ8SiJY3Eq1Ot/pQG0kV0lVPN
        pV+Xzk0n1yOuonE603s7Lx+wIzVxhfB/0D0Pzhk=
X-Google-Smtp-Source: ABdhPJycVrRW5Mk2wh/N2KprihBz5nvFtbfXjXKmoMiV73Bw53gjjS73fK+o6jkxDfogG7ydMZv0RlM8xNJBvcHN/uA=
X-Received: by 2002:aca:724a:: with SMTP id p71mr1797443oic.157.1604068755332;
 Fri, 30 Oct 2020 07:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1604042072.git.mchehab+huawei@kernel.org> <55a89f423cf122982c462d257722e44d6ece4b36.1604042072.git.mchehab+huawei@kernel.org>
In-Reply-To: <55a89f423cf122982c462d257722e44d6ece4b36.1604042072.git.mchehab+huawei@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Oct 2020 15:39:03 +0100
Message-ID: <CAJZ5v0gxmeRMaJeZ=SvLc-kS_aC2TqdTRObuwrYJFoqBdQ+y-w@mail.gmail.com>
Subject: Re: [PATCH v2 28/39] docs: ABI: fix syntax to be parsed using ReST notation
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Akira Shimahara <akira215corp@gmail.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Andy Shevchenko <andy@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Darren Hart <dvhart@infradead.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Luwei Kang <luwei.kang@intel.com>,
        Marek Behun <marek.behun@nic.cz>,
        Michal Simek <michal.simek@xilinx.com>,
        Philippe Bergheaud <felix@linux.ibm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Richard Gong <richard.gong@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 30, 2020 at 8:41 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> There are a number of new changes at the ABI files that cause
> them to produce warnings when generating ABI output.
>
> Fix them.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../ABI/stable/sysfs-driver-firmware-zynqmp   | 62 ++++++++-----
>  Documentation/ABI/testing/debugfs-moxtet      | 28 ++++--
>  .../ABI/testing/debugfs-turris-mox-rwtm       |  6 +-
>  .../sysfs-bus-event_source-devices-dfl_fme    | 14 +--
>  Documentation/ABI/testing/sysfs-bus-most      |  6 +-
>  Documentation/ABI/testing/sysfs-class-devfreq |  6 +-
>  Documentation/ABI/testing/sysfs-class-ocxl    | 14 +--
>  .../ABI/testing/sysfs-class-power-wilco       | 18 ++--
>  .../ABI/testing/sysfs-class-rnbd-client       | 93 ++++++++++---------
>  .../ABI/testing/sysfs-class-rtrs-client       | 23 +++--
>  .../sysfs-devices-platform-stratix10-rsu      | 10 ++
>  .../ABI/testing/sysfs-driver-w1_therm         | 75 ++++++++++-----
>  .../ABI/testing/sysfs-platform-dfl-fme        | 14 ++-
>  Documentation/ABI/testing/sysfs-platform-dptf | 11 ++-

For the DPTF part

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>  .../sysfs-platform-intel-wmi-sbl-fw-update    |  1 +
>  .../testing/sysfs-platform-mellanox-bootctl   | 50 ++++++----
>  .../ABI/testing/sysfs-platform-wilco-ec       |  1 +
>  17 files changed, 271 insertions(+), 161 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> index 00fa04c76ff3..f5724bb5b462 100644
> --- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> +++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> @@ -12,13 +12,15 @@ Description:
>                 resets. Three registers are used by the FSBL and
>                 other Xilinx software products: GLOBAL_GEN_STORAGE{4:6}.
>
> -               Usage:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
> -               # echo <value> > /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
> +               Usage::
>
> -               Example:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
> -               # echo 0x1234ABCD > /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
> +                   # echo <value> > /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
> +
> +               Example::
> +
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
> +                   # echo 0x1234ABCD > /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
>
>  Users:         Xilinx
>
> @@ -39,13 +41,15 @@ Description:
>                 software products: PERS_GLOB_GEN_STORAGE{4:7}.
>                 Register is reset only by a POR reset.
>
> -               Usage:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
> -               # echo <value> > /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
> +               Usage::
>
> -               Example:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
> -               # echo 0x1234ABCD > /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
> +                   # echo <value> > /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
> +
> +               Example::
> +
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
> +                   # echo 0x1234ABCD > /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
>
>  Users:         Xilinx
>
> @@ -61,23 +65,28 @@ Description:
>
>                 Following are available shutdown scopes(subtypes):
>
> -               subsystem:      Only the APU along with all of its peripherals
> +               subsystem:
> +                               Only the APU along with all of its peripherals
>                                 not used by other processing units will be
>                                 shut down. This may result in the FPD power
>                                 domain being shut down provided that no other
>                                 processing unit uses FPD peripherals or DRAM.
> -               ps_only:        The complete PS will be shut down, including the
> +               ps_only:
> +                               The complete PS will be shut down, including the
>                                 RPU, PMU, etc.  Only the PL domain (FPGA)
>                                 remains untouched.
> -               system:         The complete system/device is shut down.
> +               system:
> +                               The complete system/device is shut down.
>
> -               Usage:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> -               # echo <scope> > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> +               Usage::
>
> -               Example:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> -               # echo "subsystem" > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> +                   # echo <scope> > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> +
> +               Example::
> +
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> +                   # echo "subsystem" > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
>
>  Users:         Xilinx
>
> @@ -94,10 +103,13 @@ Description:
>                 system restart.
>
>                 Usage:
> -               Set healthy bit
> -               # echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
>
> -               Unset healthy bit
> -               # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
> +               Set healthy bit::
> +
> +                   # echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
> +
> +               Unset healthy bit::
> +
> +                   # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
>
>  Users:         Xilinx
> diff --git a/Documentation/ABI/testing/debugfs-moxtet b/Documentation/ABI/testing/debugfs-moxtet
> index 67b1717794d8..15dfaecb2892 100644
> --- a/Documentation/ABI/testing/debugfs-moxtet
> +++ b/Documentation/ABI/testing/debugfs-moxtet
> @@ -5,10 +5,16 @@ Contact:      Marek Behún <marek.behun@nic.cz>
>  Description:   (R) Read input from the shift registers, in hexadecimal.
>                 Returns N+1 bytes, where N is the number of Moxtet connected
>                 modules. The first byte is from the CPU board itself.
> -               Example: 101214
> -                        10: CPU board with SD card
> -                        12: 2 = PCIe module, 1 = IRQ not active
> -                        14: 4 = Peridot module, 1 = IRQ not active
> +
> +               Example::
> +
> +                       101214
> +
> +               ==  =======================================
> +               10  CPU board with SD card
> +               12  2 = PCIe module, 1 = IRQ not active
> +               14  4 = Peridot module, 1 = IRQ not active
> +               ==  =======================================
>
>  What:          /sys/kernel/debug/moxtet/output
>  Date:          March 2019
> @@ -17,7 +23,13 @@ Contact:     Marek Behún <marek.behun@nic.cz>
>  Description:   (RW) Read last written value to the shift registers, in
>                 hexadecimal, or write values to the shift registers, also
>                 in hexadecimal.
> -               Example: 0102
> -                        01: 01 was last written, or is to be written, to the
> -                            first module's shift register
> -                        02: the same for second module
> +
> +               Example::
> +
> +                   0102
> +
> +               ==  ================================================
> +               01  01 was last written, or is to be written, to the
> +                   first module's shift register
> +               02  the same for second module
> +               ==  ================================================
> diff --git a/Documentation/ABI/testing/debugfs-turris-mox-rwtm b/Documentation/ABI/testing/debugfs-turris-mox-rwtm
> index 2b3255ee68fd..c8f7dadd591c 100644
> --- a/Documentation/ABI/testing/debugfs-turris-mox-rwtm
> +++ b/Documentation/ABI/testing/debugfs-turris-mox-rwtm
> @@ -2,8 +2,10 @@ What:          /sys/kernel/debug/turris-mox-rwtm/do_sign
>  Date:          Jun 2020
>  KernelVersion: 5.8
>  Contact:       Marek Behún <marek.behun@nic.cz>
> -Description:   (W) Message to sign with the ECDSA private key stored in
> +Description:   (W)
> +                   Message to sign with the ECDSA private key stored in
>                     device's OTP. The message must be exactly 64 bytes (since
>                     this is intended for SHA-512 hashes).
> -               (R) The resulting signature, 136 bytes. This contains the R and
> +               (R)
> +                   The resulting signature, 136 bytes. This contains the R and
>                     S values of the ECDSA signature, both in big-endian format.
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme b/Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme
> index c9278a3b3df1..63a32ddcb95e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme
> @@ -8,13 +8,13 @@ Description:  Read-only. Attribute group to describe the magic bits
>
>                 Each attribute under this group defines a bit range of the
>                 perf_event_attr.config. All supported attributes are listed
> -               below.
> +               below::
>
>                     event  = "config:0-11"  - event ID
>                     evtype = "config:12-15" - event type
>                     portid = "config:16-23" - event source
>
> -               For example,
> +               For example::
>
>                     fab_mmio_read = "event=0x06,evtype=0x02,portid=0xff"
>
> @@ -40,11 +40,11 @@ Description:        Read-only. Attribute group to describe performance monitoring
>
>                 All supported performance monitoring events are listed below.
>
> -               Basic events (evtype=0x00)
> +               Basic events (evtype=0x00)::
>
>                     clock = "event=0x00,evtype=0x00,portid=0xff"
>
> -               Cache events (evtype=0x01)
> +               Cache events (evtype=0x01)::
>
>                     cache_read_hit      = "event=0x00,evtype=0x01,portid=0xff"
>                     cache_read_miss     = "event=0x01,evtype=0x01,portid=0xff"
> @@ -59,7 +59,7 @@ Description:  Read-only. Attribute group to describe performance monitoring
>                     cache_rx_req_stall  = "event=0x09,evtype=0x01,portid=0xff"
>                     cache_eviction      = "event=0x0a,evtype=0x01,portid=0xff"
>
> -               Fabric events (evtype=0x02)
> +               Fabric events (evtype=0x02)::
>
>                     fab_pcie0_read       = "event=0x00,evtype=0x02,portid=0xff"
>                     fab_pcie0_write      = "event=0x01,evtype=0x02,portid=0xff"
> @@ -78,7 +78,7 @@ Description:  Read-only. Attribute group to describe performance monitoring
>                     fab_port_mmio_read   = "event=0x06,evtype=0x02,portid=?"
>                     fab_port_mmio_write  = "event=0x07,evtype=0x02,portid=?"
>
> -               VTD events (evtype=0x03)
> +               VTD events (evtype=0x03)::
>
>                     vtd_port_read_transaction  = "event=0x00,evtype=0x03,portid=?"
>                     vtd_port_write_transaction = "event=0x01,evtype=0x03,portid=?"
> @@ -88,7 +88,7 @@ Description:  Read-only. Attribute group to describe performance monitoring
>                     vtd_port_devtlb_2m_fill    = "event=0x05,evtype=0x03,portid=?"
>                     vtd_port_devtlb_1g_fill    = "event=0x06,evtype=0x03,portid=?"
>
> -               VTD SIP events (evtype=0x04)
> +               VTD SIP events (evtype=0x04)::
>
>                     vtd_sip_iotlb_4k_hit  = "event=0x00,evtype=0x04,portid=0xff"
>                     vtd_sip_iotlb_2m_hit  = "event=0x01,evtype=0x04,portid=0xff"
> diff --git a/Documentation/ABI/testing/sysfs-bus-most b/Documentation/ABI/testing/sysfs-bus-most
> index ec0a603d804b..38cc03e408e7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-most
> +++ b/Documentation/ABI/testing/sysfs-bus-most
> @@ -235,7 +235,8 @@ KernelVersion:      4.15
>  Contact:       Christian Gromm <christian.gromm@microchip.com>
>  Description:
>                 This is to read back the configured direction of the channel.
> -               The following strings will be accepted:
> +               The following strings will be accepted::
> +
>                         'tx',
>                         'rx'
>  Users:
> @@ -246,7 +247,8 @@ KernelVersion:      4.15
>  Contact:       Christian Gromm <christian.gromm@microchip.com>
>  Description:
>                 This is to read back the configured data type of the channel.
> -               The following strings will be accepted:
> +               The following strings will be accepted::
> +
>                         'control',
>                         'async',
>                         'sync',
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index 67af3f31e17c..386bc230a33d 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -48,7 +48,8 @@ Description:
>                 driver should provide the list of available frequencies
>                 with its profile. If need to reset the statistics of devfreq
>                 behavior on a specific device, enter 0(zero) to 'trans_stat'
> -               as following:
> +               as following::
> +
>                         echo 0 > /sys/class/devfreq/.../trans_stat
>
>  What:          /sys/class/devfreq/.../available_frequencies
> @@ -124,7 +125,8 @@ Description:
>                 This work timer is used by devfreq workqueue in order to
>                 monitor the device status such as utilization. The user
>                 can change the work timer on runtime according to their demand
> -               as following:
> +               as following::
> +
>                         echo deferrable > /sys/class/devfreq/.../timer
>                         echo delayed > /sys/class/devfreq/.../timer
>
> diff --git a/Documentation/ABI/testing/sysfs-class-ocxl b/Documentation/ABI/testing/sysfs-class-ocxl
> index bf33f4fda58f..847a7edc3113 100644
> --- a/Documentation/ABI/testing/sysfs-class-ocxl
> +++ b/Documentation/ABI/testing/sysfs-class-ocxl
> @@ -13,8 +13,8 @@ Description:  read only
>                 where:
>
>                         ====    ===============================================
> -                       n:      number of currently active contexts, for debug
> -                       max:    maximum number of contexts supported by the AFU
> +                       n       number of currently active contexts, for debug
> +                       max     maximum number of contexts supported by the AFU
>                         ====    ===============================================
>
>  What:          /sys/class/ocxl/<afu name>/pp_mmio_size
> @@ -43,7 +43,9 @@ Contact:      linuxppc-dev@lists.ozlabs.org
>  Description:   read/write
>                 Control whether the FPGA is reloaded on a link reset. Enabled
>                 through a vendor-specific logic block on the FPGA.
> -                       0       Do not reload FPGA image from flash
> -                       1       Reload FPGA image from flash
> -                       unavailable
> -                               The device does not support this capability
> +
> +                       ===========  ===========================================
> +                       0            Do not reload FPGA image from flash
> +                       1            Reload FPGA image from flash
> +                       unavailable  The device does not support this capability
> +                       ===========  ===========================================
> diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Documentation/ABI/testing/sysfs-class-power-wilco
> index 84fde1d0ada0..82af180fcaab 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-wilco
> +++ b/Documentation/ABI/testing/sysfs-class-power-wilco
> @@ -4,17 +4,23 @@ KernelVersion:        5.2
>  Description:
>                 What charging algorithm to use:
>
> -               Standard: Fully charges battery at a standard rate.
> -               Adaptive: Battery settings adaptively optimized based on
> +               Standard:
> +                       Fully charges battery at a standard rate.
> +               Adaptive:
> +                       Battery settings adaptively optimized based on
>                         typical battery usage pattern.
> -               Fast: Battery charges over a shorter period.
> -               Trickle: Extends battery lifespan, intended for users who
> +               Fast:
> +                       Battery charges over a shorter period.
> +               Trickle:
> +                       Extends battery lifespan, intended for users who
>                         primarily use their Chromebook while connected to AC.
> -               Custom: A low and high threshold percentage is specified.
> +               Custom:
> +                       A low and high threshold percentage is specified.
>                         Charging begins when level drops below
>                         charge_control_start_threshold, and ceases when
>                         level is above charge_control_end_threshold.
> -               Long Life: Customized charge rate for last longer battery life.
> +               Long Life:
> +                       Customized charge rate for last longer battery life.
>                         On Wilco device this mode is pre-configured in the factory
>                         through EC's private PID. Swiching to a different mode will
>                         be denied by Wilco EC when Long Life mode is enabled.
> diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Documentation/ABI/testing/sysfs-class-rnbd-client
> index c084f203b41e..00c0286733d4 100644
> --- a/Documentation/ABI/testing/sysfs-class-rnbd-client
> +++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
> @@ -5,62 +5,70 @@ Contact:      Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud
>  Description:   Provide information about RNBD-client.
>                 All sysfs files that are not read-only provide the usage information on read:
>
> -               Example:
> -               # cat /sys/class/rnbd-client/ctl/map_device
> +               Example::
>
> -               > Usage: echo "sessname=<name of the rtrs session> path=<[srcaddr,]dstaddr>
> -               > [path=<[srcaddr,]dstaddr>] device_path=<full path on remote side>
> -               > [access_mode=<ro|rw|migration>] > map_device
> -               >
> -               > addr ::= [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]
> +                   # cat /sys/class/rnbd-client/ctl/map_device
> +
> +                   > Usage: echo "sessname=<name of the rtrs session> path=<[srcaddr,]dstaddr>
> +                   > [path=<[srcaddr,]dstaddr>] device_path=<full path on remote side>
> +                   > [access_mode=<ro|rw|migration>] > map_device
> +                   >
> +                   > addr ::= [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]
>
>  What:          /sys/class/rnbd-client/ctl/map_device
>  Date:          Feb 2020
>  KernelVersion: 5.7
>  Contact:       Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
> -Description:   Expected format is the following:
> +Description:   Expected format is the following::
>
> -               sessname=<name of the rtrs session>
> -               path=<[srcaddr,]dstaddr> [path=<[srcaddr,]dstaddr> ...]
> -               device_path=<full path on remote side>
> -               [access_mode=<ro|rw|migration>]
> +                   sessname=<name of the rtrs session>
> +                   path=<[srcaddr,]dstaddr> [path=<[srcaddr,]dstaddr> ...]
> +                   device_path=<full path on remote side>
> +                   [access_mode=<ro|rw|migration>]
>
>                 Where:
>
> -               sessname: accepts a string not bigger than 256 chars, which identifies
> -               a given session on the client and on the server.
> -               I.e. "clt_hostname-srv_hostname" could be a natural choice.
> +               sessname:
> +                   accepts a string not bigger than 256 chars, which identifies
> +                   a given session on the client and on the server.
> +                   I.e. "clt_hostname-srv_hostname" could be a natural choice.
>
> -               path:     describes a connection between the client and the server by
> -               specifying destination and, when required, the source address.
> -               The addresses are to be provided in the following format:
> +               path:
> +                   describes a connection between the client and the server by
> +                   specifying destination and, when required, the source address.
> +                   The addresses are to be provided in the following format::
>
> -               ip:<IPv6>
> -               ip:<IPv4>
> -               gid:<GID>
> +                       ip:<IPv6>
> +                       ip:<IPv4>
> +                       gid:<GID>
>
> -               for example:
> +               for example::
> +
> +                   path=ip:10.0.0.66
>
> -               path=ip:10.0.0.66
>                 The single addr is treated as the destination.
>                 The connection will be established to this server from any client IP address.
>
> -               path=ip:10.0.0.66,ip:10.0.1.66
> +               ::
> +
> +                   path=ip:10.0.0.66,ip:10.0.1.66
> +
>                 First addr is the source address and the second is the destination.
>
>                 If multiple "path=" options are specified multiple connection
>                 will be established and data will be sent according to
>                 the selected multipath policy (see RTRS mp_policy sysfs entry description).
>
> -               device_path: Path to the block device on the server side. Path is specified
> -               relative to the directory on server side configured in the
> -               'dev_search_path' module parameter of the rnbd_server.
> -               The rnbd_server prepends the <device_path> received from client
> -               with <dev_search_path> and tries to open the
> -               <dev_search_path>/<device_path> block device.  On success,
> -               a /dev/rnbd<N> device file, a /sys/block/rnbd_client/rnbd<N>/
> -               directory and an entry in /sys/class/rnbd-client/ctl/devices
> -               will be created.
> +               device_path:
> +                   Path to the block device on the server side. Path is specified
> +                   relative to the directory on server side configured in the
> +                   'dev_search_path' module parameter of the rnbd_server.
> +                   The rnbd_server prepends the <device_path> received from client
> +                   with <dev_search_path> and tries to open the
> +                   <dev_search_path>/<device_path> block device.  On success,
> +                   a /dev/rnbd<N> device file, a /sys/block/rnbd_client/rnbd<N>/
> +                   directory and an entry in /sys/class/rnbd-client/ctl/devices
> +                   will be created.
>
>                 If 'dev_search_path' contains '%SESSNAME%', then each session can
>                 have different devices namespace, e.g. server was configured with
> @@ -68,11 +76,12 @@ Description:        Expected format is the following:
>                 client has this string "sessname=blya device_path=sda", then server
>                 will try to open: /run/rnbd-devs/blya/sda.
>
> -               access_mode: the access_mode parameter specifies if the device is to be
> -               mapped as "ro" read-only or "rw" read-write. The server allows
> -               a device to be exported in rw mode only once. The "migration"
> -               access mode has to be specified if a second mapping in read-write
> -               mode is desired.
> +               access_mode:
> +                   the access_mode parameter specifies if the device is to be
> +                   mapped as "ro" read-only or "rw" read-write. The server allows
> +                   a device to be exported in rw mode only once. The "migration"
> +                   access mode has to be specified if a second mapping in read-write
> +                   mode is desired.
>
>                 By default "rw" is used.
>
> @@ -91,7 +100,7 @@ Description: Expected format is the following:
>                 is the same as the device name.  By extracting the last part of the
>                 path the path to the device /dev/<dev-name> can be build.
>
> -               o /dev/block/$(cat /sys/class/rnbd-client/ctl/devices/<device_id>/dev)
> +               * /dev/block/$(cat /sys/class/rnbd-client/ctl/devices/<device_id>/dev)
>
>                 How to find the <device_id> of the device is described on the next
>                 section.
> @@ -106,6 +115,6 @@ Description:        For each device mapped on the client a new symbolic link is created
>                 The <device_id> of each device is created as follows:
>
>                 - If the 'device_path' provided during mapping contains slashes ("/"),
> -               they are replaced by exclamation mark ("!") and used as as the
> -               <device_id>. Otherwise, the <device_id> will be the same as the
> -               "device_path" provided.
> +                 they are replaced by exclamation mark ("!") and used as as the
> +                 <device_id>. Otherwise, the <device_id> will be the same as the
> +                 "device_path" provided.
> diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
> index e7e718db8941..0f7165aab251 100644
> --- a/Documentation/ABI/testing/sysfs-class-rtrs-client
> +++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
> @@ -10,10 +10,10 @@ Date:               Feb 2020
>  KernelVersion: 5.7
>  Contact:       Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
>  Description:   RW, adds a new path (connection) to an existing session. Expected format is the
> -               following:
> +               following::
>
> -               <[source addr,]destination addr>
> -               *addr ::= [ ip:<ipv4|ipv6> | gid:<gid> ]
> +                   <[source addr,]destination addr>
> +                   *addr ::= [ ip:<ipv4|ipv6> | gid:<gid> ]
>
>  What:          /sys/class/rtrs-client/<session-name>/max_reconnect_attempts
>  Date:          Feb 2020
> @@ -29,10 +29,10 @@ Contact:    Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud
>  Description:   Multipath policy specifies which path should be selected on each IO:
>
>                 round-robin (0):
> -               select path in per CPU round-robin manner.
> +                   select path in per CPU round-robin manner.
>
>                 min-inflight (1):
> -               select path with minimum inflights.
> +                   select path with minimum inflights.
>
>  What:          /sys/class/rtrs-client/<session-name>/paths/
>  Date:          Feb 2020
> @@ -109,8 +109,11 @@ Description:       RTRS expects that each HCA IRQ is pinned to a separate CPU. If it's
>                 not the case, the processing of an I/O response could be processed on a
>                 different CPU than where it was originally submitted.  This file shows
>                 how many interrupts where generated on a non expected CPU.
> -               "from:" is the CPU on which the IRQ was expected, but not generated.
> -               "to:" is the CPU on which the IRQ was generated, but not expected.
> +
> +               "from:"
> +                   is the CPU on which the IRQ was expected, but not generated.
> +               "to:"
> +                   is the CPU on which the IRQ was generated, but not expected.
>
>  What:          /sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/reconnects
>  Date:          Feb 2020
> @@ -125,7 +128,7 @@ Date:               Feb 2020
>  KernelVersion: 5.7
>  Contact:       Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
>  Description:   Contains statistics regarding rdma operations and inflight operations.
> -               The output consists of 6 values:
> +               The output consists of 6 values::
>
> -               <read-count> <read-total-size> <write-count> <write-total-size> \
> -               <inflights> <failovered>
> +                   <read-count> <read-total-size> <write-count> \
> +                   <write-total-size> <inflights> <failovered>
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> index a8daceb4a956..ee253b033280 100644
> --- a/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> @@ -102,6 +102,8 @@ Description:
>                 b[15:0]
>                         inform firmware the current software execution
>                         stage.
> +
> +                       ==      ===========================================
>                         0       the first stage bootloader didn't run or
>                                 didn't reach the point of launching second
>                                 stage bootloader.
> @@ -111,21 +113,29 @@ Description:
>                         2       both first and second stage bootloader ran
>                                 and the operating system launch was
>                                 attempted.
> +                       ==      ===========================================
>
>                 b[16]
> +                       ==      ===========================================
>                         1       firmware to reset current image retry
>                                 counter.
>                         0       no action.
> +                       ==      ===========================================
>
>                 b[17]
> +                       ==      ===========================================
>                         1       firmware to clear RSU log
>                         0       no action.
> +                       ==      ===========================================
>
>                 b[18]
>                         this is negative logic
> +
> +                       ==      ===========================================
>                         1       no action
>                         0       firmware record the notify code defined
>                                 in b[15:0].
> +                       ==      ===========================================
>
>  What:          /sys/devices/platform/stratix10-rsu.0/dcmf0
>  Date:          June 2020
> diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
> index 8873bbb075cb..6a37dc33ffdb 100644
> --- a/Documentation/ABI/testing/sysfs-driver-w1_therm
> +++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
> @@ -22,8 +22,10 @@ Description:
>                 device data to its embedded EEPROM, either restore data
>                 embedded in device EEPROM. Be aware that devices support
>                 limited EEPROM writing cycles (typical 50k)
> +
>                         * 'save': save device RAM to EEPROM
>                         * 'restore': restore EEPROM data in device RAM
> +
>  Users:         any user space application which wants to communicate with
>                 w1_term device
>
> @@ -33,9 +35,11 @@ Date:                May 2020
>  Contact:       Akira Shimahara <akira215corp@gmail.com>
>  Description:
>                 (RO) return the power status by asking the device
> +
>                         * '0': device parasite powered
>                         * '1': device externally powered
>                         * '-xx': xx is kernel error when reading power status
> +
>  Users:         any user space application which wants to communicate with
>                 w1_term device
>
> @@ -49,10 +53,12 @@ Description:
>                 will be changed only in device RAM, so it will be cleared when
>                 power is lost. Trigger a 'save' to EEPROM command to keep
>                 values after power-on. Read or write are :
> +
>                         * '9..14': device resolution in bit
> -                       or resolution to set in bit
> +                         or resolution to set in bit
>                         * '-xx': xx is kernel error when reading the resolution
>                         * Anything else: do nothing
> +
>                 Some DS18B20 clones are fixed in 12-bit resolution, so the
>                 actual resolution is read back from the chip and verified. Error
>                 is reported if the results differ.
> @@ -65,16 +71,18 @@ Date:               May 2020
>  Contact:       Akira Shimahara <akira215corp@gmail.com>
>  Description:
>                 (RO) return the temperature in 1/1000 degC.
> +
>                         * If a bulk read has been triggered, it will directly
> -                       return the temperature computed when the bulk read
> -                       occurred, if available. If not yet available, nothing
> -                       is returned (a debug kernel message is sent), you
> -                       should retry later on.
> +                         return the temperature computed when the bulk read
> +                         occurred, if available. If not yet available, nothing
> +                         is returned (a debug kernel message is sent), you
> +                         should retry later on.
>                         * If no bulk read has been triggered, it will trigger
> -                       a conversion and send the result. Note that the
> -                       conversion duration depend on the resolution (if
> -                       device support this feature). It takes 94ms in 9bits
> -                       resolution, 750ms for 12bits.
> +                         a conversion and send the result. Note that the
> +                         conversion duration depend on the resolution (if
> +                         device support this feature). It takes 94ms in 9bits
> +                         resolution, 750ms for 12bits.
> +
>  Users:         any user space application which wants to communicate with
>                 w1_term device
>
> @@ -86,12 +94,14 @@ Description:
>                 (RW) return the temperature in 1/1000 degC.
>                 *read*: return 2 lines with the hexa output data sent on the
>                 bus, return the CRC check and temperature in 1/1000 degC
> -               *write* :
> +               *write*:
> +
>                         * '0' : save the 2 or 3 bytes to the device EEPROM
> -                       (i.e. TH, TL and config register)
> +                         (i.e. TH, TL and config register)
>                         * '9..14' : set the device resolution in RAM
> -                       (if supported)
> +                         (if supported)
>                         * Anything else: do nothing
> +
>                 refer to Documentation/w1/slaves/w1_therm.rst for detailed
>                 information.
>  Users:         any user space application which wants to communicate with
> @@ -103,14 +113,21 @@ Date:             May 2020
>  Contact:       Akira Shimahara <akira215corp@gmail.com>
>  Description:
>                 (RW) trigger a bulk read conversion. read the status
> +
>                 *read*:
> -                       * '-1': conversion in progress on at least 1 sensor
> -                       * '1' : conversion complete but at least one sensor
> +                       * '-1':
> +                               conversion in progress on at least 1 sensor
> +                       * '1' :
> +                               conversion complete but at least one sensor
>                                 value has not been read yet
> -                       * '0' : no bulk operation. Reading temperature will
> +                       * '0' :
> +                               no bulk operation. Reading temperature will
>                                 trigger a conversion on each device
> -               *write*: 'trigger': trigger a bulk read on all supporting
> +
> +               *write*:
> +                       'trigger': trigger a bulk read on all supporting
>                         devices on the bus
> +
>                 Note that if a bulk read is sent but one sensor is not read
>                 immediately, the next access to temperature on this device
>                 will return the temperature measured at the time of issue
> @@ -128,14 +145,19 @@ Description:
>                 reset to default (datasheet) conversion time for a new
>                 resolution.
>
> -               *read*: Actual conversion time in milliseconds. *write*:
> -                       '0': Set the default conversion time from the datasheet.
> -                       '1': Measure and set the conversion time. Make a single
> +               *read*:
> +                       Actual conversion time in milliseconds.
> +
> +               *write*:
> +                       * '0':
> +                            Set the default conversion time from the datasheet.
> +                       * '1':
> +                            Measure and set the conversion time. Make a single
>                              temperature conversion, measure an actual value.
>                              Increase it by 20% for temperature range. A new
>                              conversion time can be obtained by reading this
>                              same attribute.
> -                       other positive value:
> +                       * other positive value:
>                              Set the conversion time in milliseconds.
>
>  Users:         An application using the w1_term device
> @@ -148,16 +170,21 @@ Description:
>                 (RW) Control optional driver settings.
>                 Bit masks to read/write (bitwise OR):
>
> -                1: Enable check for conversion success. If byte 6 of
> +               == ============================================================
> +                 1 Enable check for conversion success. If byte 6 of
>                     scratchpad memory is 0xC after conversion, and
>                     temperature reads 85.00 (powerup value) or 127.94
>                     (insufficient power) - return a conversion error.
>
> -                2: Enable poll for conversion completion. Generate read cycles
> +                2  Enable poll for conversion completion. Generate read cycles
>                     after the conversion start and wait for 1's. In parasite
>                     power mode this feature is not available.
> +               == ============================================================
>
> -               *read*:  Currently selected features.
> -               *write*: Select features.
> +               *read*:
> +                   Currently selected features.
> +
> +               *write*:
> +                   Select features.
>
>  Users:         An application using the w1_term device
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> index 3683cb1cdc3d..d6ab34e81b9b 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> @@ -113,8 +113,11 @@ KernelVersion:     5.5
>  Contact:       Wu Hao <hao.wu@intel.com>
>  Description:   Read-Only. Read this file to get the name of hwmon device, it
>                 supports values:
> -                   'dfl_fme_thermal' - thermal hwmon device name
> -                   'dfl_fme_power'   - power hwmon device name
> +
> +               =================  =========================
> +               'dfl_fme_thermal'  thermal hwmon device name
> +               'dfl_fme_power'    power hwmon device name
> +               =================  =========================
>
>  What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_input
>  Date:          October 2019
> @@ -169,8 +172,11 @@ KernelVersion:     5.5
>  Contact:       Wu Hao <hao.wu@intel.com>
>  Description:   Read-Only. Read this file to get the policy of hardware threshold1
>                 (see 'temp1_max'). It only supports two values (policies):
> -                   0 - AP2 state (90% throttling)
> -                   1 - AP1 state (50% throttling)
> +
> +               ==  ==========================
> +                0  AP2 state (90% throttling)
> +                1  AP1 state (50% throttling)
> +               ==  ==========================
>
>  What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_input
>  Date:          October 2019
> diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
> index 2cbc660d163b..141834342a4d 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dptf
> +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> @@ -27,12 +27,15 @@ KernelVersion:      v4.10
>  Contact:       linux-acpi@vger.kernel.org
>  Description:
>                 (RO) Display the platform power source
> +
> +               ========= ============================
>                 bits[3:0] Current power source
> -                       0x00 = DC
> -                       0x01 = AC
> -                       0x02 = USB
> -                       0x03 = Wireless Charger
> +                         - 0x00 = DC
> +                         - 0x01 = AC
> +                         - 0x02 = USB
> +                         - 0x03 = Wireless Charger
>                 bits[7:4] Power source sequence number
> +               ========= ============================
>
>  What:          /sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power
>  Date:          Jul, 2016
> diff --git a/Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-update b/Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-update
> index 5aa618987cad..02ae1e9bbfc8 100644
> --- a/Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-update
> +++ b/Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-update
> @@ -8,5 +8,6 @@ Description:
>                 of 0 and userspace can signal SBL to update firmware,
>                 on next reboot, by writing a value of 1.
>                 There are two available states:
> +
>                     * 0 -> Skip firmware update while rebooting
>                     * 1 -> Attempt firmware update on next reboot
> diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> index 401d202f478b..e79ca22e2f45 100644
> --- a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> @@ -5,10 +5,13 @@ Contact:      "Liming Sun <lsun@mellanox.com>"
>  Description:
>                 The Life-cycle state of the SoC, which could be one of the
>                 following values.
> -                 Production - Production state and can be updated to secure
> -                 GA Secured - Secure chip and not able to change state
> -                 GA Non-Secured - Non-Secure chip and not able to change state
> -                 RMA - Return Merchandise Authorization
> +
> +               ==============  =============================================
> +               Production      Production state and can be updated to secure
> +               GA Secured      Secure chip and not able to change state
> +               GA Non-Secured  Non-Secure chip and not able to change state
> +               RMA             Return Merchandise Authorization
> +               ==============  =============================================
>
>  What:          /sys/bus/platform/devices/MLNXBF04:00/post_reset_wdog
>  Date:          Oct 2019
> @@ -25,10 +28,13 @@ KernelVersion:      5.5
>  Contact:       "Liming Sun <lsun@mellanox.com>"
>  Description:
>                 The source of the boot stream for the next reset. It could be
> -               one of the following values.
> -                 external - boot from external source (USB or PCIe)
> -                 emmc - boot from the onchip eMMC
> -                 emmc_legacy - boot from the onchip eMMC in legacy (slow) mode
> +               one of the following values:
> +
> +               ===========  ===============================================
> +               external     boot from external source (USB or PCIe)
> +               emmc         boot from the onchip eMMC
> +               emmc_legacy  boot from the onchip eMMC in legacy (slow) mode
> +               ===========  ===============================================
>
>  What:          /sys/bus/platform/devices/MLNXBF04:00/second_reset_action
>  Date:          Oct 2019
> @@ -38,11 +44,14 @@ Description:
>                 Update the source of the boot stream after next reset. It could
>                 be one of the following values and will be applied after next
>                 reset.
> -                 external - boot from external source (USB or PCIe)
> -                 emmc - boot from the onchip eMMC
> -                 emmc_legacy - boot from the onchip eMMC in legacy (slow) mode
> -                 swap_emmc - swap the primary / secondary boot partition
> -                 none - cancel the action
> +
> +               ===========  ===============================================
> +               external     boot from external source (USB or PCIe)
> +               emmc         boot from the onchip eMMC
> +               emmc_legacy  boot from the onchip eMMC in legacy (slow) mode
> +               swap_emmc    swap the primary / secondary boot partition
> +               none         cancel the action
> +               ===========  ===============================================
>
>  What:          /sys/bus/platform/devices/MLNXBF04:00/secure_boot_fuse_state
>  Date:          Oct 2019
> @@ -50,9 +59,12 @@ KernelVersion:       5.5
>  Contact:       "Liming Sun <lsun@mellanox.com>"
>  Description:
>                 The state of eFuse versions with the following values.
> -                 InUse - burnt, valid and currently in use
> -                 Used - burnt and valid
> -                 Free - not burnt and free to use
> -                 Skipped - not burnt but not free (skipped)
> -                 Wasted - burnt and invalid
> -                 Invalid - not burnt but marked as valid (error state).
> +
> +               =======  ===============================================
> +               InUse    burnt, valid and currently in use
> +               Used     burnt and valid
> +               Free     not burnt and free to use
> +               Skipped  not burnt but not free (skipped)
> +               Wasted   burnt and invalid
> +               Invalid  not burnt but marked as valid (error state).
> +               =======  ===============================================
> diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
> index 5f60b184a5a5..4439d0644091 100644
> --- a/Documentation/ABI/testing/sysfs-platform-wilco-ec
> +++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
> @@ -39,6 +39,7 @@ Description:
>                 which affects charging via the special USB PowerShare port
>                 (marked with a small lightning bolt or battery icon) when in
>                 low power states:
> +
>                 - In S0, the port will always provide power.
>                 - In S0ix, if usb_charge is enabled, then power will be
>                   supplied to the port when on AC or if battery is > 50%.
> --
> 2.26.2
>
