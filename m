Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6CB2A2471
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 06:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgKBFvH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 00:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgKBFvH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 00:51:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF07C061A04
        for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2020 21:51:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id a15so4306759edy.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2020 21:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mfXBkU4q5bwFdxoPkDgpCRrqoTTL828rZFuCA+z9scw=;
        b=ZARK21VhYbHKsK5NEuPMcZdpcWQSTJZleuxs5c+v22Fgek+ntpFPtUJLk7mFZlUFLD
         cQTOXR4aJvJM86J1frrKZii6Q96mdQPInF1mstdSvIxFfoEMsSgVVXZEXktdwevUyMLp
         MvIYVv3Knll8wjPeoPAaBQUWQIConeutIpU9hU6dDD3mVRHlQmMCp/ufC6z83q/9OHYd
         pPLTIuq17rtgmJp0jXgfbFUtTs5nBjg25TBsLCsG643VNf3scNf35ymHaMp8II1KE5qW
         kn9NC+HRylQMPcG+OF/hyi5HYwQWw+q+eIQDTmAuITaogkBoJmjBkHpTFOxAypezasCG
         pG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mfXBkU4q5bwFdxoPkDgpCRrqoTTL828rZFuCA+z9scw=;
        b=VQFz5KZ/kXC/d3PQnJ+EFOlRL5IGRLZT00pqYPh3p105e6v64h1mdooAKUnCewm4li
         WR6YF8+nvJ5V6D+A484ooNbsFpUWWyG22yQsOnQz4tGAA13DphivEUibknjbFS6Ry05s
         4RfTxjTeqXTtl2V9n7TDfEBG1ciSR5UXcIyliM867YQvJsxqQOHEca3YGqqqRs1d1IBA
         dyX7oPWONSwZ7nr8z8cyoN8n9uYojOFf63JhvdcHCawbGnJs4ifpwM5OvlkHuzOXX3JN
         YEeoXnFBVmDnMQOflXNFYlvo/M3brJBjxZem8JLnRXee+/RozkmY1Ry9wo5pUAOWAQSs
         KasQ==
X-Gm-Message-State: AOAM532/SUs13nRIcZQqOF5d7+fjhQJoH1F2a92LJBoUB2cbBIuWcrNm
        yZdyj4ubANB7xMT4nbREdAZ0+WlN+NxYuxFaqyAxQQ==
X-Google-Smtp-Source: ABdhPJypgAQrUpp6HONlELmFgnyiHEsTKRbk0GVsqKbK5m0VoNk1nMfujYPhCegsxIOSeLUfbsw1CH+/Og6yiftSvxw=
X-Received: by 2002:a05:6402:290:: with SMTP id l16mr13528631edv.104.1604296264394;
 Sun, 01 Nov 2020 21:51:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604042072.git.mchehab+huawei@kernel.org> <55a89f423cf122982c462d257722e44d6ece4b36.1604042072.git.mchehab+huawei@kernel.org>
In-Reply-To: <55a89f423cf122982c462d257722e44d6ece4b36.1604042072.git.mchehab+huawei@kernel.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Nov 2020 06:50:53 +0100
Message-ID: <CAMGffEk14z2EfDx+_srY83+UeH6jJTepAEFGW3h-0BTBy7uXzQ@mail.gmail.com>
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
For rnbd/rtrs, looks good to me, thanks!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
>  .../sysfs-devices-platform-stratix10-rsu      | 10 ++
>  .../ABI/testing/sysfs-driver-w1_therm         | 75 ++++++++++-----
>  .../ABI/testing/sysfs-platform-dfl-fme        | 14 ++-
>  Documentation/ABI/testing/sysfs-platform-dptf | 11 ++-
>  .../sysfs-platform-intel-wmi-sbl-fw-update    |  1 +
>  .../testing/sysfs-platform-mellanox-bootctl   | 50 ++++++----
>  .../ABI/testing/sysfs-platform-wilco-ec       |  1 +
>  17 files changed, 271 insertions(+), 161 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Docu=
mentation/ABI/stable/sysfs-driver-firmware-zynqmp
> index 00fa04c76ff3..f5724bb5b462 100644
> --- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> +++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> @@ -12,13 +12,15 @@ Description:
>                 resets. Three registers are used by the FSBL and
>                 other Xilinx software products: GLOBAL_GEN_STORAGE{4:6}.
>
> -               Usage:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/ggs=
0
> -               # echo <value> > /sys/devices/platform/firmware\:zynqmp-f=
irmware/ggs0
> +               Usage::
>
> -               Example:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/ggs=
0
> -               # echo 0x1234ABCD > /sys/devices/platform/firmware\:zynqm=
p-firmware/ggs0
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware=
/ggs0
> +                   # echo <value> > /sys/devices/platform/firmware\:zynq=
mp-firmware/ggs0
> +
> +               Example::
> +
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware=
/ggs0
> +                   # echo 0x1234ABCD > /sys/devices/platform/firmware\:z=
ynqmp-firmware/ggs0
>
>  Users:         Xilinx
>
> @@ -39,13 +41,15 @@ Description:
>                 software products: PERS_GLOB_GEN_STORAGE{4:7}.
>                 Register is reset only by a POR reset.
>
> -               Usage:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/pgg=
s0
> -               # echo <value> > /sys/devices/platform/firmware\:zynqmp-f=
irmware/pggs0
> +               Usage::
>
> -               Example:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/pgg=
s0
> -               # echo 0x1234ABCD > /sys/devices/platform/firmware\:zynqm=
p-firmware/pggs0
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware=
/pggs0
> +                   # echo <value> > /sys/devices/platform/firmware\:zynq=
mp-firmware/pggs0
> +
> +               Example::
> +
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware=
/pggs0
> +                   # echo 0x1234ABCD > /sys/devices/platform/firmware\:z=
ynqmp-firmware/pggs0
>
>  Users:         Xilinx
>
> @@ -61,23 +65,28 @@ Description:
>
>                 Following are available shutdown scopes(subtypes):
>
> -               subsystem:      Only the APU along with all of its periph=
erals
> +               subsystem:
> +                               Only the APU along with all of its periph=
erals
>                                 not used by other processing units will b=
e
>                                 shut down. This may result in the FPD pow=
er
>                                 domain being shut down provided that no o=
ther
>                                 processing unit uses FPD peripherals or D=
RAM.
> -               ps_only:        The complete PS will be shut down, includ=
ing the
> +               ps_only:
> +                               The complete PS will be shut down, includ=
ing the
>                                 RPU, PMU, etc.  Only the PL domain (FPGA)
>                                 remains untouched.
> -               system:         The complete system/device is shut down.
> +               system:
> +                               The complete system/device is shut down.
>
> -               Usage:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/shu=
tdown_scope
> -               # echo <scope> > /sys/devices/platform/firmware\:zynqmp-f=
irmware/shutdown_scope
> +               Usage::
>
> -               Example:
> -               # cat /sys/devices/platform/firmware\:zynqmp-firmware/shu=
tdown_scope
> -               # echo "subsystem" > /sys/devices/platform/firmware\:zynq=
mp-firmware/shutdown_scope
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware=
/shutdown_scope
> +                   # echo <scope> > /sys/devices/platform/firmware\:zynq=
mp-firmware/shutdown_scope
> +
> +               Example::
> +
> +                   # cat /sys/devices/platform/firmware\:zynqmp-firmware=
/shutdown_scope
> +                   # echo "subsystem" > /sys/devices/platform/firmware\:=
zynqmp-firmware/shutdown_scope
>
>  Users:         Xilinx
>
> @@ -94,10 +103,13 @@ Description:
>                 system restart.
>
>                 Usage:
> -               Set healthy bit
> -               # echo 1 > /sys/devices/platform/firmware\:zynqmp-firmwar=
e/health_status
>
> -               Unset healthy bit
> -               # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmwar=
e/health_status
> +               Set healthy bit::
> +
> +                   # echo 1 > /sys/devices/platform/firmware\:zynqmp-fir=
mware/health_status
> +
> +               Unset healthy bit::
> +
> +                   # echo 0 > /sys/devices/platform/firmware\:zynqmp-fir=
mware/health_status
>
>  Users:         Xilinx
> diff --git a/Documentation/ABI/testing/debugfs-moxtet b/Documentation/ABI=
/testing/debugfs-moxtet
> index 67b1717794d8..15dfaecb2892 100644
> --- a/Documentation/ABI/testing/debugfs-moxtet
> +++ b/Documentation/ABI/testing/debugfs-moxtet
> @@ -5,10 +5,16 @@ Contact:      Marek Beh=C3=BAn <marek.behun@nic.cz>
>  Description:   (R) Read input from the shift registers, in hexadecimal.
>                 Returns N+1 bytes, where N is the number of Moxtet connec=
ted
>                 modules. The first byte is from the CPU board itself.
> -               Example: 101214
> -                        10: CPU board with SD card
> -                        12: 2 =3D PCIe module, 1 =3D IRQ not active
> -                        14: 4 =3D Peridot module, 1 =3D IRQ not active
> +
> +               Example::
> +
> +                       101214
> +
> +               =3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +               10  CPU board with SD card
> +               12  2 =3D PCIe module, 1 =3D IRQ not active
> +               14  4 =3D Peridot module, 1 =3D IRQ not active
> +               =3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/kernel/debug/moxtet/output
>  Date:          March 2019
> @@ -17,7 +23,13 @@ Contact:     Marek Beh=C3=BAn <marek.behun@nic.cz>
>  Description:   (RW) Read last written value to the shift registers, in
>                 hexadecimal, or write values to the shift registers, also
>                 in hexadecimal.
> -               Example: 0102
> -                        01: 01 was last written, or is to be written, to=
 the
> -                            first module's shift register
> -                        02: the same for second module
> +
> +               Example::
> +
> +                   0102
> +
> +               =3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +               01  01 was last written, or is to be written, to the
> +                   first module's shift register
> +               02  the same for second module
> +               =3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/ABI/testing/debugfs-turris-mox-rwtm b/Document=
ation/ABI/testing/debugfs-turris-mox-rwtm
> index 2b3255ee68fd..c8f7dadd591c 100644
> --- a/Documentation/ABI/testing/debugfs-turris-mox-rwtm
> +++ b/Documentation/ABI/testing/debugfs-turris-mox-rwtm
> @@ -2,8 +2,10 @@ What:          /sys/kernel/debug/turris-mox-rwtm/do_sign
>  Date:          Jun 2020
>  KernelVersion: 5.8
>  Contact:       Marek Beh=C3=BAn <marek.behun@nic.cz>
> -Description:   (W) Message to sign with the ECDSA private key stored in
> +Description:   (W)
> +                   Message to sign with the ECDSA private key stored in
>                     device's OTP. The message must be exactly 64 bytes (s=
ince
>                     this is intended for SHA-512 hashes).
> -               (R) The resulting signature, 136 bytes. This contains the=
 R and
> +               (R)
> +                   The resulting signature, 136 bytes. This contains the=
 R and
>                     S values of the ECDSA signature, both in big-endian f=
ormat.
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl=
_fme b/Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme
> index c9278a3b3df1..63a32ddcb95e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme
> @@ -8,13 +8,13 @@ Description:  Read-only. Attribute group to describe th=
e magic bits
>
>                 Each attribute under this group defines a bit range of th=
e
>                 perf_event_attr.config. All supported attributes are list=
ed
> -               below.
> +               below::
>
>                     event  =3D "config:0-11"  - event ID
>                     evtype =3D "config:12-15" - event type
>                     portid =3D "config:16-23" - event source
>
> -               For example,
> +               For example::
>
>                     fab_mmio_read =3D "event=3D0x06,evtype=3D0x02,portid=
=3D0xff"
>
> @@ -40,11 +40,11 @@ Description:        Read-only. Attribute group to des=
cribe performance monitoring
>
>                 All supported performance monitoring events are listed be=
low.
>
> -               Basic events (evtype=3D0x00)
> +               Basic events (evtype=3D0x00)::
>
>                     clock =3D "event=3D0x00,evtype=3D0x00,portid=3D0xff"
>
> -               Cache events (evtype=3D0x01)
> +               Cache events (evtype=3D0x01)::
>
>                     cache_read_hit      =3D "event=3D0x00,evtype=3D0x01,p=
ortid=3D0xff"
>                     cache_read_miss     =3D "event=3D0x01,evtype=3D0x01,p=
ortid=3D0xff"
> @@ -59,7 +59,7 @@ Description:  Read-only. Attribute group to describe pe=
rformance monitoring
>                     cache_rx_req_stall  =3D "event=3D0x09,evtype=3D0x01,p=
ortid=3D0xff"
>                     cache_eviction      =3D "event=3D0x0a,evtype=3D0x01,p=
ortid=3D0xff"
>
> -               Fabric events (evtype=3D0x02)
> +               Fabric events (evtype=3D0x02)::
>
>                     fab_pcie0_read       =3D "event=3D0x00,evtype=3D0x02,=
portid=3D0xff"
>                     fab_pcie0_write      =3D "event=3D0x01,evtype=3D0x02,=
portid=3D0xff"
> @@ -78,7 +78,7 @@ Description:  Read-only. Attribute group to describe pe=
rformance monitoring
>                     fab_port_mmio_read   =3D "event=3D0x06,evtype=3D0x02,=
portid=3D?"
>                     fab_port_mmio_write  =3D "event=3D0x07,evtype=3D0x02,=
portid=3D?"
>
> -               VTD events (evtype=3D0x03)
> +               VTD events (evtype=3D0x03)::
>
>                     vtd_port_read_transaction  =3D "event=3D0x00,evtype=
=3D0x03,portid=3D?"
>                     vtd_port_write_transaction =3D "event=3D0x01,evtype=
=3D0x03,portid=3D?"
> @@ -88,7 +88,7 @@ Description:  Read-only. Attribute group to describe pe=
rformance monitoring
>                     vtd_port_devtlb_2m_fill    =3D "event=3D0x05,evtype=
=3D0x03,portid=3D?"
>                     vtd_port_devtlb_1g_fill    =3D "event=3D0x06,evtype=
=3D0x03,portid=3D?"
>
> -               VTD SIP events (evtype=3D0x04)
> +               VTD SIP events (evtype=3D0x04)::
>
>                     vtd_sip_iotlb_4k_hit  =3D "event=3D0x00,evtype=3D0x04=
,portid=3D0xff"
>                     vtd_sip_iotlb_2m_hit  =3D "event=3D0x01,evtype=3D0x04=
,portid=3D0xff"
> diff --git a/Documentation/ABI/testing/sysfs-bus-most b/Documentation/ABI=
/testing/sysfs-bus-most
> index ec0a603d804b..38cc03e408e7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-most
> +++ b/Documentation/ABI/testing/sysfs-bus-most
> @@ -235,7 +235,8 @@ KernelVersion:      4.15
>  Contact:       Christian Gromm <christian.gromm@microchip.com>
>  Description:
>                 This is to read back the configured direction of the chan=
nel.
> -               The following strings will be accepted:
> +               The following strings will be accepted::
> +
>                         'tx',
>                         'rx'
>  Users:
> @@ -246,7 +247,8 @@ KernelVersion:      4.15
>  Contact:       Christian Gromm <christian.gromm@microchip.com>
>  Description:
>                 This is to read back the configured data type of the chan=
nel.
> -               The following strings will be accepted:
> +               The following strings will be accepted::
> +
>                         'control',
>                         'async',
>                         'sync',
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentatio=
n/ABI/testing/sysfs-class-devfreq
> index 67af3f31e17c..386bc230a33d 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -48,7 +48,8 @@ Description:
>                 driver should provide the list of available frequencies
>                 with its profile. If need to reset the statistics of devf=
req
>                 behavior on a specific device, enter 0(zero) to 'trans_st=
at'
> -               as following:
> +               as following::
> +
>                         echo 0 > /sys/class/devfreq/.../trans_stat
>
>  What:          /sys/class/devfreq/.../available_frequencies
> @@ -124,7 +125,8 @@ Description:
>                 This work timer is used by devfreq workqueue in order to
>                 monitor the device status such as utilization. The user
>                 can change the work timer on runtime according to their d=
emand
> -               as following:
> +               as following::
> +
>                         echo deferrable > /sys/class/devfreq/.../timer
>                         echo delayed > /sys/class/devfreq/.../timer
>
> diff --git a/Documentation/ABI/testing/sysfs-class-ocxl b/Documentation/A=
BI/testing/sysfs-class-ocxl
> index bf33f4fda58f..847a7edc3113 100644
> --- a/Documentation/ABI/testing/sysfs-class-ocxl
> +++ b/Documentation/ABI/testing/sysfs-class-ocxl
> @@ -13,8 +13,8 @@ Description:  read only
>                 where:
>
>                         =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -                       n:      number of currently active contexts, for =
debug
> -                       max:    maximum number of contexts supported by t=
he AFU
> +                       n       number of currently active contexts, for =
debug
> +                       max     maximum number of contexts supported by t=
he AFU
>                         =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/class/ocxl/<afu name>/pp_mmio_size
> @@ -43,7 +43,9 @@ Contact:      linuxppc-dev@lists.ozlabs.org
>  Description:   read/write
>                 Control whether the FPGA is reloaded on a link reset. Ena=
bled
>                 through a vendor-specific logic block on the FPGA.
> -                       0       Do not reload FPGA image from flash
> -                       1       Reload FPGA image from flash
> -                       unavailable
> -                               The device does not support this capabili=
ty
> +
> +                       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                       0            Do not reload FPGA image from flash
> +                       1            Reload FPGA image from flash
> +                       unavailable  The device does not support this cap=
ability
> +                       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Document=
ation/ABI/testing/sysfs-class-power-wilco
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
>                         primarily use their Chromebook while connected to=
 AC.
> -               Custom: A low and high threshold percentage is specified.
> +               Custom:
> +                       A low and high threshold percentage is specified.
>                         Charging begins when level drops below
>                         charge_control_start_threshold, and ceases when
>                         level is above charge_control_end_threshold.
> -               Long Life: Customized charge rate for last longer battery=
 life.
> +               Long Life:
> +                       Customized charge rate for last longer battery li=
fe.
>                         On Wilco device this mode is pre-configured in th=
e factory
>                         through EC's private PID. Swiching to a different=
 mode will
>                         be denied by Wilco EC when Long Life mode is enab=
led.
> diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Document=
ation/ABI/testing/sysfs-class-rnbd-client
> index c084f203b41e..00c0286733d4 100644
> --- a/Documentation/ABI/testing/sysfs-class-rnbd-client
> +++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
> @@ -5,62 +5,70 @@ Contact:      Jack Wang <jinpu.wang@cloud.ionos.com> Da=
nil Kipnis <danil.kipnis@cloud
>  Description:   Provide information about RNBD-client.
>                 All sysfs files that are not read-only provide the usage =
information on read:
>
> -               Example:
> -               # cat /sys/class/rnbd-client/ctl/map_device
> +               Example::
>
> -               > Usage: echo "sessname=3D<name of the rtrs session> path=
=3D<[srcaddr,]dstaddr>
> -               > [path=3D<[srcaddr,]dstaddr>] device_path=3D<full path o=
n remote side>
> -               > [access_mode=3D<ro|rw|migration>] > map_device
> -               >
> -               > addr ::=3D [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]
> +                   # cat /sys/class/rnbd-client/ctl/map_device
> +
> +                   > Usage: echo "sessname=3D<name of the rtrs session> =
path=3D<[srcaddr,]dstaddr>
> +                   > [path=3D<[srcaddr,]dstaddr>] device_path=3D<full pa=
th on remote side>
> +                   > [access_mode=3D<ro|rw|migration>] > map_device
> +                   >
> +                   > addr ::=3D [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]
>
>  What:          /sys/class/rnbd-client/ctl/map_device
>  Date:          Feb 2020
>  KernelVersion: 5.7
>  Contact:       Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <dani=
l.kipnis@cloud.ionos.com>
> -Description:   Expected format is the following:
> +Description:   Expected format is the following::
>
> -               sessname=3D<name of the rtrs session>
> -               path=3D<[srcaddr,]dstaddr> [path=3D<[srcaddr,]dstaddr> ..=
.]
> -               device_path=3D<full path on remote side>
> -               [access_mode=3D<ro|rw|migration>]
> +                   sessname=3D<name of the rtrs session>
> +                   path=3D<[srcaddr,]dstaddr> [path=3D<[srcaddr,]dstaddr=
> ...]
> +                   device_path=3D<full path on remote side>
> +                   [access_mode=3D<ro|rw|migration>]
>
>                 Where:
>
> -               sessname: accepts a string not bigger than 256 chars, whi=
ch identifies
> -               a given session on the client and on the server.
> -               I.e. "clt_hostname-srv_hostname" could be a natural choic=
e.
> +               sessname:
> +                   accepts a string not bigger than 256 chars, which ide=
ntifies
> +                   a given session on the client and on the server.
> +                   I.e. "clt_hostname-srv_hostname" could be a natural c=
hoice.
>
> -               path:     describes a connection between the client and t=
he server by
> -               specifying destination and, when required, the source add=
ress.
> -               The addresses are to be provided in the following format:
> +               path:
> +                   describes a connection between the client and the ser=
ver by
> +                   specifying destination and, when required, the source=
 address.
> +                   The addresses are to be provided in the following for=
mat::
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
> +                   path=3Dip:10.0.0.66
>
> -               path=3Dip:10.0.0.66
>                 The single addr is treated as the destination.
>                 The connection will be established to this server from an=
y client IP address.
>
> -               path=3Dip:10.0.0.66,ip:10.0.1.66
> +               ::
> +
> +                   path=3Dip:10.0.0.66,ip:10.0.1.66
> +
>                 First addr is the source address and the second is the de=
stination.
>
>                 If multiple "path=3D" options are specified multiple conn=
ection
>                 will be established and data will be sent according to
>                 the selected multipath policy (see RTRS mp_policy sysfs e=
ntry description).
>
> -               device_path: Path to the block device on the server side.=
 Path is specified
> -               relative to the directory on server side configured in th=
e
> -               'dev_search_path' module parameter of the rnbd_server.
> -               The rnbd_server prepends the <device_path> received from =
client
> -               with <dev_search_path> and tries to open the
> -               <dev_search_path>/<device_path> block device.  On success=
,
> -               a /dev/rnbd<N> device file, a /sys/block/rnbd_client/rnbd=
<N>/
> -               directory and an entry in /sys/class/rnbd-client/ctl/devi=
ces
> -               will be created.
> +               device_path:
> +                   Path to the block device on the server side. Path is =
specified
> +                   relative to the directory on server side configured i=
n the
> +                   'dev_search_path' module parameter of the rnbd_server=
.
> +                   The rnbd_server prepends the <device_path> received f=
rom client
> +                   with <dev_search_path> and tries to open the
> +                   <dev_search_path>/<device_path> block device.  On suc=
cess,
> +                   a /dev/rnbd<N> device file, a /sys/block/rnbd_client/=
rnbd<N>/
> +                   directory and an entry in /sys/class/rnbd-client/ctl/=
devices
> +                   will be created.
>
>                 If 'dev_search_path' contains '%SESSNAME%', then each ses=
sion can
>                 have different devices namespace, e.g. server was configu=
red with
> @@ -68,11 +76,12 @@ Description:        Expected format is the following:
>                 client has this string "sessname=3Dblya device_path=3Dsda=
", then server
>                 will try to open: /run/rnbd-devs/blya/sda.
>
> -               access_mode: the access_mode parameter specifies if the d=
evice is to be
> -               mapped as "ro" read-only or "rw" read-write. The server a=
llows
> -               a device to be exported in rw mode only once. The "migrat=
ion"
> -               access mode has to be specified if a second mapping in re=
ad-write
> -               mode is desired.
> +               access_mode:
> +                   the access_mode parameter specifies if the device is =
to be
> +                   mapped as "ro" read-only or "rw" read-write. The serv=
er allows
> +                   a device to be exported in rw mode only once. The "mi=
gration"
> +                   access mode has to be specified if a second mapping i=
n read-write
> +                   mode is desired.
>
>                 By default "rw" is used.
>
> @@ -91,7 +100,7 @@ Description: Expected format is the following:
>                 is the same as the device name.  By extracting the last p=
art of the
>                 path the path to the device /dev/<dev-name> can be build.
>
> -               o /dev/block/$(cat /sys/class/rnbd-client/ctl/devices/<de=
vice_id>/dev)
> +               * /dev/block/$(cat /sys/class/rnbd-client/ctl/devices/<de=
vice_id>/dev)
>
>                 How to find the <device_id> of the device is described on=
 the next
>                 section.
> @@ -106,6 +115,6 @@ Description:        For each device mapped on the cli=
ent a new symbolic link is created
>                 The <device_id> of each device is created as follows:
>
>                 - If the 'device_path' provided during mapping contains s=
lashes ("/"),
> -               they are replaced by exclamation mark ("!") and used as a=
s the
> -               <device_id>. Otherwise, the <device_id> will be the same =
as the
> -               "device_path" provided.
> +                 they are replaced by exclamation mark ("!") and used as=
 as the
> +                 <device_id>. Otherwise, the <device_id> will be the sam=
e as the
> +                 "device_path" provided.
> diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Document=
ation/ABI/testing/sysfs-class-rtrs-client
> index e7e718db8941..0f7165aab251 100644
> --- a/Documentation/ABI/testing/sysfs-class-rtrs-client
> +++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
> @@ -10,10 +10,10 @@ Date:               Feb 2020
>  KernelVersion: 5.7
>  Contact:       Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <dani=
l.kipnis@cloud.ionos.com>
>  Description:   RW, adds a new path (connection) to an existing session. =
Expected format is the
> -               following:
> +               following::
>
> -               <[source addr,]destination addr>
> -               *addr ::=3D [ ip:<ipv4|ipv6> | gid:<gid> ]
> +                   <[source addr,]destination addr>
> +                   *addr ::=3D [ ip:<ipv4|ipv6> | gid:<gid> ]
>
>  What:          /sys/class/rtrs-client/<session-name>/max_reconnect_attem=
pts
>  Date:          Feb 2020
> @@ -29,10 +29,10 @@ Contact:    Jack Wang <jinpu.wang@cloud.ionos.com> Da=
nil Kipnis <danil.kipnis@cloud
>  Description:   Multipath policy specifies which path should be selected =
on each IO:
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
> @@ -109,8 +109,11 @@ Description:       RTRS expects that each HCA IRQ is=
 pinned to a separate CPU. If it's
>                 not the case, the processing of an I/O response could be =
processed on a
>                 different CPU than where it was originally submitted.  Th=
is file shows
>                 how many interrupts where generated on a non expected CPU=
.
> -               "from:" is the CPU on which the IRQ was expected, but not=
 generated.
> -               "to:" is the CPU on which the IRQ was generated, but not =
expected.
> +
> +               "from:"
> +                   is the CPU on which the IRQ was expected, but not gen=
erated.
> +               "to:"
> +                   is the CPU on which the IRQ was generated, but not ex=
pected.
>
>  What:          /sys/class/rtrs-client/<session-name>/paths/<src@dst>/sta=
ts/reconnects
>  Date:          Feb 2020
> @@ -125,7 +128,7 @@ Date:               Feb 2020
>  KernelVersion: 5.7
>  Contact:       Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <dani=
l.kipnis@cloud.ionos.com>
>  Description:   Contains statistics regarding rdma operations and infligh=
t operations.
> -               The output consists of 6 values:
> +               The output consists of 6 values::
>
> -               <read-count> <read-total-size> <write-count> <write-total=
-size> \
> -               <inflights> <failovered>
> +                   <read-count> <read-total-size> <write-count> \
> +                   <write-total-size> <inflights> <failovered>
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-stratix10-r=
su b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> index a8daceb4a956..ee253b033280 100644
> --- a/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> @@ -102,6 +102,8 @@ Description:
>                 b[15:0]
>                         inform firmware the current software execution
>                         stage.
> +
> +                       =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>                         0       the first stage bootloader didn't run or
>                                 didn't reach the point of launching secon=
d
>                                 stage bootloader.
> @@ -111,21 +113,29 @@ Description:
>                         2       both first and second stage bootloader ra=
n
>                                 and the operating system launch was
>                                 attempted.
> +                       =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
>                 b[16]
> +                       =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>                         1       firmware to reset current image retry
>                                 counter.
>                         0       no action.
> +                       =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
>                 b[17]
> +                       =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>                         1       firmware to clear RSU log
>                         0       no action.
> +                       =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
>                 b[18]
>                         this is negative logic
> +
> +                       =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>                         1       no action
>                         0       firmware record the notify code defined
>                                 in b[15:0].
> +                       =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/devices/platform/stratix10-rsu.0/dcmf0
>  Date:          June 2020
> diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentat=
ion/ABI/testing/sysfs-driver-w1_therm
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
>  Users:         any user space application which wants to communicate wit=
h
>                 w1_term device
>
> @@ -33,9 +35,11 @@ Date:                May 2020
>  Contact:       Akira Shimahara <akira215corp@gmail.com>
>  Description:
>                 (RO) return the power status by asking the device
> +
>                         * '0': device parasite powered
>                         * '1': device externally powered
>                         * '-xx': xx is kernel error when reading power st=
atus
> +
>  Users:         any user space application which wants to communicate wit=
h
>                 w1_term device
>
> @@ -49,10 +53,12 @@ Description:
>                 will be changed only in device RAM, so it will be cleared=
 when
>                 power is lost. Trigger a 'save' to EEPROM command to keep
>                 values after power-on. Read or write are :
> +
>                         * '9..14': device resolution in bit
> -                       or resolution to set in bit
> +                         or resolution to set in bit
>                         * '-xx': xx is kernel error when reading the reso=
lution
>                         * Anything else: do nothing
> +
>                 Some DS18B20 clones are fixed in 12-bit resolution, so th=
e
>                 actual resolution is read back from the chip and verified=
. Error
>                 is reported if the results differ.
> @@ -65,16 +71,18 @@ Date:               May 2020
>  Contact:       Akira Shimahara <akira215corp@gmail.com>
>  Description:
>                 (RO) return the temperature in 1/1000 degC.
> +
>                         * If a bulk read has been triggered, it will dire=
ctly
> -                       return the temperature computed when the bulk rea=
d
> -                       occurred, if available. If not yet available, not=
hing
> -                       is returned (a debug kernel message is sent), you
> -                       should retry later on.
> +                         return the temperature computed when the bulk r=
ead
> +                         occurred, if available. If not yet available, n=
othing
> +                         is returned (a debug kernel message is sent), y=
ou
> +                         should retry later on.
>                         * If no bulk read has been triggered, it will tri=
gger
> -                       a conversion and send the result. Note that the
> -                       conversion duration depend on the resolution (if
> -                       device support this feature). It takes 94ms in 9b=
its
> -                       resolution, 750ms for 12bits.
> +                         a conversion and send the result. Note that the
> +                         conversion duration depend on the resolution (i=
f
> +                         device support this feature). It takes 94ms in =
9bits
> +                         resolution, 750ms for 12bits.
> +
>  Users:         any user space application which wants to communicate wit=
h
>                 w1_term device
>
> @@ -86,12 +94,14 @@ Description:
>                 (RW) return the temperature in 1/1000 degC.
>                 *read*: return 2 lines with the hexa output data sent on =
the
>                 bus, return the CRC check and temperature in 1/1000 degC
> -               *write* :
> +               *write*:
> +
>                         * '0' : save the 2 or 3 bytes to the device EEPRO=
M
> -                       (i.e. TH, TL and config register)
> +                         (i.e. TH, TL and config register)
>                         * '9..14' : set the device resolution in RAM
> -                       (if supported)
> +                         (if supported)
>                         * Anything else: do nothing
> +
>                 refer to Documentation/w1/slaves/w1_therm.rst for detaile=
d
>                 information.
>  Users:         any user space application which wants to communicate wit=
h
> @@ -103,14 +113,21 @@ Date:             May 2020
>  Contact:       Akira Shimahara <akira215corp@gmail.com>
>  Description:
>                 (RW) trigger a bulk read conversion. read the status
> +
>                 *read*:
> -                       * '-1': conversion in progress on at least 1 sens=
or
> -                       * '1' : conversion complete but at least one sens=
or
> +                       * '-1':
> +                               conversion in progress on at least 1 sens=
or
> +                       * '1' :
> +                               conversion complete but at least one sens=
or
>                                 value has not been read yet
> -                       * '0' : no bulk operation. Reading temperature wi=
ll
> +                       * '0' :
> +                               no bulk operation. Reading temperature wi=
ll
>                                 trigger a conversion on each device
> -               *write*: 'trigger': trigger a bulk read on all supporting
> +
> +               *write*:
> +                       'trigger': trigger a bulk read on all supporting
>                         devices on the bus
> +
>                 Note that if a bulk read is sent but one sensor is not re=
ad
>                 immediately, the next access to temperature on this devic=
e
>                 will return the temperature measured at the time of issue
> @@ -128,14 +145,19 @@ Description:
>                 reset to default (datasheet) conversion time for a new
>                 resolution.
>
> -               *read*: Actual conversion time in milliseconds. *write*:
> -                       '0': Set the default conversion time from the dat=
asheet.
> -                       '1': Measure and set the conversion time. Make a =
single
> +               *read*:
> +                       Actual conversion time in milliseconds.
> +
> +               *write*:
> +                       * '0':
> +                            Set the default conversion time from the dat=
asheet.
> +                       * '1':
> +                            Measure and set the conversion time. Make a =
single
>                              temperature conversion, measure an actual va=
lue.
>                              Increase it by 20% for temperature range. A =
new
>                              conversion time can be obtained by reading t=
his
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
> +               =3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                 1 Enable check for conversion success. If byte 6 of
>                     scratchpad memory is 0xC after conversion, and
>                     temperature reads 85.00 (powerup value) or 127.94
>                     (insufficient power) - return a conversion error.
>
> -                2: Enable poll for conversion completion. Generate read =
cycles
> +                2  Enable poll for conversion completion. Generate read =
cycles
>                     after the conversion start and wait for 1's. In paras=
ite
>                     power mode this feature is not available.
> +               =3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documenta=
tion/ABI/testing/sysfs-platform-dfl-fme
> index 3683cb1cdc3d..d6ab34e81b9b 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> @@ -113,8 +113,11 @@ KernelVersion:     5.5
>  Contact:       Wu Hao <hao.wu@intel.com>
>  Description:   Read-Only. Read this file to get the name of hwmon device=
, it
>                 supports values:
> -                   'dfl_fme_thermal' - thermal hwmon device name
> -                   'dfl_fme_power'   - power hwmon device name
> +
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +               'dfl_fme_thermal'  thermal hwmon device name
> +               'dfl_fme_power'    power hwmon device name
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_in=
put
>  Date:          October 2019
> @@ -169,8 +172,11 @@ KernelVersion:     5.5
>  Contact:       Wu Hao <hao.wu@intel.com>
>  Description:   Read-Only. Read this file to get the policy of hardware t=
hreshold1
>                 (see 'temp1_max'). It only supports two values (policies)=
:
> -                   0 - AP2 state (90% throttling)
> -                   1 - AP1 state (50% throttling)
> +
> +               =3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                0  AP2 state (90% throttling)
> +                1  AP1 state (50% throttling)
> +               =3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_i=
nput
>  Date:          October 2019
> diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentatio=
n/ABI/testing/sysfs-platform-dptf
> index 2cbc660d163b..141834342a4d 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dptf
> +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> @@ -27,12 +27,15 @@ KernelVersion:      v4.10
>  Contact:       linux-acpi@vger.kernel.org
>  Description:
>                 (RO) Display the platform power source
> +
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                 bits[3:0] Current power source
> -                       0x00 =3D DC
> -                       0x01 =3D AC
> -                       0x02 =3D USB
> -                       0x03 =3D Wireless Charger
> +                         - 0x00 =3D DC
> +                         - 0x01 =3D AC
> +                         - 0x02 =3D USB
> +                         - 0x03 =3D Wireless Charger
>                 bits[7:4] Power source sequence number
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/bus/platform/devices/INT3407:00/dptf_power/battery_s=
teady_power
>  Date:          Jul, 2016
> diff --git a/Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-up=
date b/Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-update
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
> diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/=
Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> index 401d202f478b..e79ca22e2f45 100644
> --- a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> @@ -5,10 +5,13 @@ Contact:      "Liming Sun <lsun@mellanox.com>"
>  Description:
>                 The Life-cycle state of the SoC, which could be one of th=
e
>                 following values.
> -                 Production - Production state and can be updated to sec=
ure
> -                 GA Secured - Secure chip and not able to change state
> -                 GA Non-Secured - Non-Secure chip and not able to change=
 state
> -                 RMA - Return Merchandise Authorization
> +
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +               Production      Production state and can be updated to se=
cure
> +               GA Secured      Secure chip and not able to change state
> +               GA Non-Secured  Non-Secure chip and not able to change st=
ate
> +               RMA             Return Merchandise Authorization
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/bus/platform/devices/MLNXBF04:00/post_reset_wdog
>  Date:          Oct 2019
> @@ -25,10 +28,13 @@ KernelVersion:      5.5
>  Contact:       "Liming Sun <lsun@mellanox.com>"
>  Description:
>                 The source of the boot stream for the next reset. It coul=
d be
> -               one of the following values.
> -                 external - boot from external source (USB or PCIe)
> -                 emmc - boot from the onchip eMMC
> -                 emmc_legacy - boot from the onchip eMMC in legacy (slow=
) mode
> +               one of the following values:
> +
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +               external     boot from external source (USB or PCIe)
> +               emmc         boot from the onchip eMMC
> +               emmc_legacy  boot from the onchip eMMC in legacy (slow) m=
ode
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/bus/platform/devices/MLNXBF04:00/second_reset_action
>  Date:          Oct 2019
> @@ -38,11 +44,14 @@ Description:
>                 Update the source of the boot stream after next reset. It=
 could
>                 be one of the following values and will be applied after =
next
>                 reset.
> -                 external - boot from external source (USB or PCIe)
> -                 emmc - boot from the onchip eMMC
> -                 emmc_legacy - boot from the onchip eMMC in legacy (slow=
) mode
> -                 swap_emmc - swap the primary / secondary boot partition
> -                 none - cancel the action
> +
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +               external     boot from external source (USB or PCIe)
> +               emmc         boot from the onchip eMMC
> +               emmc_legacy  boot from the onchip eMMC in legacy (slow) m=
ode
> +               swap_emmc    swap the primary / secondary boot partition
> +               none         cancel the action
> +               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/bus/platform/devices/MLNXBF04:00/secure_boot_fuse_st=
ate
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
> +               =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +               InUse    burnt, valid and currently in use
> +               Used     burnt and valid
> +               Free     not burnt and free to use
> +               Skipped  not burnt but not free (skipped)
> +               Wasted   burnt and invalid
> +               Invalid  not burnt but marked as valid (error state).
> +               =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Document=
ation/ABI/testing/sysfs-platform-wilco-ec
> index 5f60b184a5a5..4439d0644091 100644
> --- a/Documentation/ABI/testing/sysfs-platform-wilco-ec
> +++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
> @@ -39,6 +39,7 @@ Description:
>                 which affects charging via the special USB PowerShare por=
t
>                 (marked with a small lightning bolt or battery icon) when=
 in
>                 low power states:
> +
>                 - In S0, the port will always provide power.
>                 - In S0ix, if usb_charge is enabled, then power will be
>                   supplied to the port when on AC or if battery is > 50%.
> --
> 2.26.2
>
