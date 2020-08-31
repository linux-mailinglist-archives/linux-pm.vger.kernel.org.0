Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298F3257E9E
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHaQXE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgHaQXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 12:23:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF92C061573;
        Mon, 31 Aug 2020 09:23:03 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v16so5807069otp.10;
        Mon, 31 Aug 2020 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4dLG1Zt/IPI+/a3J8l/0wzUefijYE2Blkm8CezvRtA=;
        b=RwBxZsWspKLQMK3XaGMrdOhl2LbDnHZtuQxrEkK1/P84qkZMoCnsLKCaj2TaLBPeiv
         /Cjf4xRO4L4/fwopa6H/XWpa7+3OZLV/8+NrPXOhtrXHQykrJnRnCOTBWLbc+h6HftSv
         QEYh+Jmey1UtFP6HB0wwtorKHP9mM4uko5yXqT8dILjhKfQHBxXD4F5HpRmbHXV4tyTa
         nEyELg71wk8TXdKJVnjjEiURYh3MRU1kJkpIip4DusCdnUSzIaodKckUNP3OLxUfHG67
         YIk7FHE9hejuTlxkhhSZbD9vr9WsQam1eO5zPsgJ+c5Fx1Z+dmp3WPk0di6A+/XXkwYj
         AbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4dLG1Zt/IPI+/a3J8l/0wzUefijYE2Blkm8CezvRtA=;
        b=Syu3Pezsub5LVoLXCX61L8UXSqIJmupN66yqTp8dhZvYujAjEfnz+aNvT/S+ZTcup4
         PIxnnAl+MhYfpSjWWtKLZf3PRTxmYDd0JY83mOefPFHdTPZK7iIeWzr6N0CZRT0oyLZF
         GHQiPrS0iEX24QWGrnr8yPZcEHU30GFGPwKfGwmXNiUTMuoBn0kjN8c886na4wJnptmU
         PhJwI5ozs7Bob8D6UcQcMpQUKGdbWt9fKTlau0zr4wq/zXoM9q8z+CoLpFcSfGgdVFo5
         zP9pvQkJsV8KNFIDY8yQmGKe2rzjbdDLZ9mWfWhzj0mO8YWAX8UX8dit3nh6bBMjbSEM
         iozw==
X-Gm-Message-State: AOAM531rNQ44zycQnPZNx/8rvdUx21jMsizad1EGbL34gM7XFI3MNRwS
        rTIyeN+SagZ3V6Uz6OJQ1q5qHhTVZ1LQf2yFpZOgaMmaEEg=
X-Google-Smtp-Source: ABdhPJxrJpBFwh9m9xbImS73NBC+UgYuXHlrXAXjgNehMyHSDt3BEBWSr08G4H463m+UXPJt1C+8Si2QVofupPntAb0=
X-Received: by 2002:a05:6830:89:: with SMTP id a9mr1398136oto.53.1598890980963;
 Mon, 31 Aug 2020 09:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPY=qRRekJonX_iX3s4bfietm9D_GM+S4cDGXbj9nMOefJBdTw@mail.gmail.com>
 <71c9048e530e1b67b6750b1a9eda175d98096ccc.camel@gmail.com>
In-Reply-To: <71c9048e530e1b67b6750b1a9eda175d98096ccc.camel@gmail.com>
From:   Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Date:   Mon, 31 Aug 2020 21:52:47 +0530
Message-ID: <CAPY=qRSbJaqOZ30556SWTgrTMegsmdb9-DoM7R66fb=rLWP6eQ@mail.gmail.com>
Subject: Re: cpu-freq: running the perf increases the data rate?
To:     dedekind1@gmail.com
Cc:     linux-pm@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000f4a3f505ae2ed049"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--000000000000f4a3f505ae2ed049
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2020 at 6:04 PM Artem Bityutskiy <dedekind1@gmail.com> wrot=
e:
>
> On Thu, 2020-08-27 at 22:25 +0530, Subhashini Rao Beerisetty wrote:
> > I have an application which finds the data rate over the PCIe
> > interface. I=E2=80=99m getting the lesser data rate in one of my Linux =
X86
> > systems.
>
> Some more description, may be? Do you have a PCIe device reading one
> RAM buffer and then writing to another RAM buffer? Or does it generate
> dome data and writes them to a RAM buffer? Presumably it uses DMA? How
> much is the CPU involved into the process? Are we talking about
> transferring few kilobytes or gigabytes?
Thanks a lot for your help and reply.
Regarding hardware setup, Xilinx PCIe FPGA endpoint is connected to
HOST CPU via PCIe bus.
Xilinx PCIe FPGA endpoint has the DMA_REF block and it provides a
mechanism to DMA transfer data at the maximum rate between host CPU
memory and a FIFO in the DMA-REF block.
The host software sets up some data in it=E2=80=99s memory, it then transfe=
rs
the data to the DMA-REF=E2=80=99s FIFO and then reads it back into a differ=
ent
location in its host memory. This is repeated in a loop.  There is a
register in the DMA-REF block that gives an indication of transfer
speed.


>
> > When I change the scaling_governor from "powersave" to "performance"
> > mode for each CPU, then there is slight improvement in the PCIe data
> > rate.
>
> Definitely this makes your CPU(s) run at max speed, but depending on
> platform and settings, this may also affect C-states. Are the CPU(s)
> generally idle while you measure, or busy (involved into the test)? You
> could run 'turbostat' while measuring the bandwidth, to get some CPU
> statistics (e.g., do C-states happen during the PCI test, how busy are
> the CPUs).
>
> > Parallely I started profiling the workload with perf. Whenever I start
> > running the profile command =E2=80=9Cperf stat -a -d -p <PID>=E2=80=9D =
surprisingly
> > the application resulted in excellent data rate over PCIe, but when I
> > kill the perf command again PCIe data rate drops. I am really confused
> > about this behavior.Any clues from this behaviour?
>
> Well, one possible reason that comes to mind - you get rid of C-states
> when you rung perf, and this increases the PCI bandwidth. You can just
> try disabling C-states (there are sysfs knobs) and check it out.
> Turbostat could be useful to check for this (with and without perf, run
> 'turbostat sleep 10' or something like this (measure for 10 seconds in
> this example), do this while running your PCI test.
Disabling the C-states improved the throughput a lot, thanks a lot for
pointing this out. Could you please give some more explanation on how
disabling C-states improved the throughput?
As you suggested I collected and attached the turbostat log with and
without perf while running the PCIe test.
In my system, only 'performance\powersave' are listed in
scaling_available_governors. Rest other governors
"userspace\ondemand\schedutil" are not listed in available_goverors.
What might be the reason for this?

>
> But I am really just guessing here, I do not know enough about your
> test and the system (e.g., "a Linux x86" system can be so many things,
> like Intel or AMD server or a mobile device)=E2=80=A6
It's an Intel Atom processor.
>
>

--000000000000f4a3f505ae2ed049
Content-Type: text/plain; charset="US-ASCII"; name="trubostat_with_perf.txt"
Content-Disposition: attachment; filename="trubostat_with_perf.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_keipum270>
X-Attachment-Id: f_keipum270

dHVyYm9zdGF0IHZlcnNpb24gMTcuMDYuMjMgLSBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz4K
Q1BVSUQoMCk6IEdlbnVpbmVJbnRlbCAxMSBDUFVJRCBsZXZlbHM7IGZhbWlseTptb2RlbDpzdGVw
cGluZyAweDY6Mzc6OSAoNjo1NTo5KQpDUFVJRCgxKTogU1NFMyBNT05JVE9SIC0gRUlTVCBUTTIg
VFNDIE1TUiBBQ1BJLVRNIFRNCkNQVUlEKDYpOiBBUEVSRiwgTm8tVFVSQk8sIERUUywgTm8tUFRN
LCBOby1IV1AsIE5vLUhXUG5vdGlmeSwgTm8tSFdQd2luZG93LCBOby1IV1BlcHAsIE5vLUhXUHBr
ZywgRVBCCmNwdTI6IE1TUl9JQTMyX01JU0NfRU5BQkxFOiAweDAwODUwMDg5IChUQ0MgRUlTVCBO
by1NV0FJVCBQUkVGRVRDSCBUVVJCTykKQ1BVSUQoNyk6IE5vLVNHWApTTE0gQkNMSzogODMuMyBN
aHoKY3B1MjogTVNSX0NDNl9ERU1PVElPTl9QT0xJQ1lfQ09ORklHOiAweDAwMDAwMDAwIChESVNh
YmxlLUNDNi1EZW1vdGlvbikKY3B1MjogTVNSX01DNl9ERU1PVElPTl9QT0xJQ1lfQ09ORklHOiAw
eDAwMDAwMDAwIChESVNhYmxlLU1DNi1EZW1vdGlvbikKUkFQTDogNDU4MSBzZWMuIEpvdWxlIENv
dW50ZXIgUmFuZ2UsIGF0IDMwIFdhdHRzCmNwdTI6IE1TUl9QTEFURk9STV9JTkZPOiAweDYwMDAw
MDAxNzAwCjYgKiA4My4zID0gNDk5LjggTUh6IG1heCBlZmZpY2llbmN5IGZyZXF1ZW5jeQoyMyAq
IDgzLjMgPSAxOTE1LjkgTUh6IGJhc2UgZnJlcXVlbmN5CmNwdTI6IE1TUl9JQTMyX1BPV0VSX0NU
TDogMHgwMDAwMDAwMCAoQzFFIGF1dG8tcHJvbW90aW9uOiBESVNhYmxlZCkKY3B1MjogTVNSX0FU
T01fQ09SRV9SQVRJT1M6IDB4MDAxNzA2MDIKMiAqIDgzLjMgPSAxNjYuNiBNSHogbWluaW11bSBv
cGVyYXRpbmcgZnJlcXVlbmN5CjYgKiA4My4zID0gNDk5LjggTUh6IGxvdyBmcmVxdWVuY3kgbW9k
ZSAoTEZNKQoyMyAqIDgzLjMgPSAxOTE1LjkgTUh6IGJhc2UgZnJlcXVlbmN5CmNwdTI6IE1TUl9B
VE9NX0NPUkVfVFVSQk9fUkFUSU9TOiAweDE3MTcxNzE3CjIzICogODMuMyA9IDE5MTUuOSBNSHog
bWF4IHR1cmJvIDQgYWN0aXZlIGNvcmVzCjIzICogODMuMyA9IDE5MTUuOSBNSHogbWF4IHR1cmJv
IDMgYWN0aXZlIGNvcmVzCjIzICogODMuMyA9IDE5MTUuOSBNSHogbWF4IHR1cmJvIDIgYWN0aXZl
IGNvcmVzCjIzICogODMuMyA9IDE5MTUuOSBNSHogbWF4IHR1cmJvIDEgYWN0aXZlIGNvcmUKY3B1
MjogTVNSX1BLR19DU1RfQ09ORklHX0NPTlRST0w6IDB4MDAxNzAwMGYgKFVObG9ja2VkOiBwa2ct
Y3N0YXRlLWxpbWl0PTE1OiBwYzcpCmNwdTI6IFBPTEw6IENQVUlETEUgQ09SRSBQT0xMIElETEUK
Y3B1MjogQzE6IE1XQUlUIDB4MDAKY3B1MjogQzZOOiBNV0FJVCAweDU4CmNwdTI6IEM2UzogTVdB
SVQgMHg1MgpjcHUyOiBjcHVmcmVxIGRyaXZlcjogaW50ZWxfcHN0YXRlCmNwdTI6IGNwdWZyZXEg
Z292ZXJub3I6IHBlcmZvcm1hbmNlCmNwdWZyZXEgaW50ZWxfcHN0YXRlIG5vX3R1cmJvOiAxCmNw
dTA6IE1TUl9JQTMyX0VORVJHWV9QRVJGX0JJQVM6IDB4MDAwMDAwMDYgKGJhbGFuY2VkKQpjcHUw
OiBNU1JfUkFQTF9QT1dFUl9VTklUOiAweDAwMDAwNTA1ICgwLjAzMTI1MCBXYXR0cywgMC4wMDAw
MzIgSm91bGVzLCAwLjAwMDk3NyBzZWMuKQpjcHUwOiBNU1JfUEtHX1BPV0VSX0xJTUlUOiAweDAw
Mzg4MGZhIChVTmxvY2tlZCkKY3B1MDogUEtHIExpbWl0ICMxOiBFTmFibGVkICg3LjgxMjUwMCBX
YXR0cywgMjYyMTQ0LjAwMDAwMCBzZWMsIGNsYW1wIERJU2FibGVkKQpjcHUwOiBQS0cgTGltaXQg
IzI6IERJU2FibGVkICgwLjAwMDAwMCBXYXR0cywgMC4wMDA5NzcqIHNlYywgY2xhbXAgRElTYWJs
ZWQpCmNwdTA6IE1TUl9QUDBfUE9XRVJfTElNSVQ6IDB4MDAwMjAwMDAgKFVObG9ja2VkKQpjcHUw
OiBDb3JlcyBMaW1pdDogRElTYWJsZWQgKDAuMDAwMDAwIFdhdHRzLCAwLjAwMTk1MyBzZWMsIGNs
YW1wIERJU2FibGVkKQpjcHUwOiBNU1JfSUEzMl9URU1QRVJBVFVSRV9UQVJHRVQ6IDB4MDA2ZTAw
MDAgKDExMCBDKQo0MC4wMDQ0MTcgc2VjCkNvcmUJQ1BVCUF2Z19NSHoJQnVzeSUJQnp5X01IeglU
U0NfTUh6CUlSUQlTTUkJQzEJQzZOCUM2UwlDMSUJQzZOJQlDNlMlCUNQVSVjMQlDUFUlYzYJTW9k
JWM2CUNvcmVUbXAJR0ZYJXJjNglQa2clcGM2CVBrZ1dhdHQJQ29yV2F0dAotCS0JNzQ4CTM5LjMz
CTE5MDEJMTkxNwk0NTg1NjAJMAkxNTY2MjgwCTE4ODkJNzc3NQk0My4wNwkwLjI5CTE4LjE5CTQy
LjIzCTE3Ljg1CTEzLjU2CTI5CTEwMC4wMAkxMS44MAkxLjE0CTAuOTUKMAkwCTY0MwkzMy44OQkx
ODk2CTE5MTcJMzM2NDcJMAk0MDUzMzkJNDkyCTE5NTAJNDguNDQJMC4zMQkxOC4yOAk0Ny41Nwkx
Ny42OQkxMy4zMgkyOAkxMDAuMDAJMTEuODAJMS4xNAkwLjk1CjEJMQkxMDY0CTU1Ljc4CTE5MDYJ
MTkxNwkzNTg1MjEJMAk0NDk4NzUJMjUJMTkxMAkyNy4zNwkwLjAzCTE3LjgzCTI2LjQxCTE3LjM0
CTEzLjMyCTI5CjIJMgk2NDcJMzQuMTQJMTg5NQkxOTE3CTMzODIxCTAJMzU5MTU1CTUxNwkxOTQw
CTQ4LjIxCTAuMjkJMTguMjAJNDcuNDMJMTcuODYJMTMuODEJMjgKMwkzCTYzOAkzMy41MgkxOTAy
CTE5MTcJMzI1NzEJMAkzNTE5MTEJODU1CTE5NzUJNDguMjcJMC41NAkxOC40Nwk0Ny41MQkxOC41
MQkxMy44MQkyOAo=
--000000000000f4a3f505ae2ed049
Content-Type: text/plain; charset="US-ASCII"; name="trubostat_without_perf.txt"
Content-Disposition: attachment; filename="trubostat_without_perf.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_keipum2v1>
X-Attachment-Id: f_keipum2v1

dHVyYm9zdGF0IHZlcnNpb24gMTcuMDYuMjMgLSBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz4K
Q1BVSUQoMCk6IEdlbnVpbmVJbnRlbCAxMSBDUFVJRCBsZXZlbHM7IGZhbWlseTptb2RlbDpzdGVw
cGluZyAweDY6Mzc6OSAoNjo1NTo5KQpDUFVJRCgxKTogU1NFMyBNT05JVE9SIC0gRUlTVCBUTTIg
VFNDIE1TUiBBQ1BJLVRNIFRNCkNQVUlEKDYpOiBBUEVSRiwgTm8tVFVSQk8sIERUUywgTm8tUFRN
LCBOby1IV1AsIE5vLUhXUG5vdGlmeSwgTm8tSFdQd2luZG93LCBOby1IV1BlcHAsIE5vLUhXUHBr
ZywgRVBCCmNwdTI6IE1TUl9JQTMyX01JU0NfRU5BQkxFOiAweDAwODUwMDg5IChUQ0MgRUlTVCBO
by1NV0FJVCBQUkVGRVRDSCBUVVJCTykKQ1BVSUQoNyk6IE5vLVNHWApTTE0gQkNMSzogODMuMyBN
aHoKY3B1MjogTVNSX0NDNl9ERU1PVElPTl9QT0xJQ1lfQ09ORklHOiAweDAwMDAwMDAwIChESVNh
YmxlLUNDNi1EZW1vdGlvbikKY3B1MjogTVNSX01DNl9ERU1PVElPTl9QT0xJQ1lfQ09ORklHOiAw
eDAwMDAwMDAwIChESVNhYmxlLU1DNi1EZW1vdGlvbikKUkFQTDogNDU4MSBzZWMuIEpvdWxlIENv
dW50ZXIgUmFuZ2UsIGF0IDMwIFdhdHRzCmNwdTI6IE1TUl9QTEFURk9STV9JTkZPOiAweDYwMDAw
MDAxNzAwCjYgKiA4My4zID0gNDk5LjggTUh6IG1heCBlZmZpY2llbmN5IGZyZXF1ZW5jeQoyMyAq
IDgzLjMgPSAxOTE1LjkgTUh6IGJhc2UgZnJlcXVlbmN5CmNwdTI6IE1TUl9JQTMyX1BPV0VSX0NU
TDogMHgwMDAwMDAwMCAoQzFFIGF1dG8tcHJvbW90aW9uOiBESVNhYmxlZCkKY3B1MjogTVNSX0FU
T01fQ09SRV9SQVRJT1M6IDB4MDAxNzA2MDIKMiAqIDgzLjMgPSAxNjYuNiBNSHogbWluaW11bSBv
cGVyYXRpbmcgZnJlcXVlbmN5CjYgKiA4My4zID0gNDk5LjggTUh6IGxvdyBmcmVxdWVuY3kgbW9k
ZSAoTEZNKQoyMyAqIDgzLjMgPSAxOTE1LjkgTUh6IGJhc2UgZnJlcXVlbmN5CmNwdTI6IE1TUl9B
VE9NX0NPUkVfVFVSQk9fUkFUSU9TOiAweDE3MTcxNzE3CjIzICogODMuMyA9IDE5MTUuOSBNSHog
bWF4IHR1cmJvIDQgYWN0aXZlIGNvcmVzCjIzICogODMuMyA9IDE5MTUuOSBNSHogbWF4IHR1cmJv
IDMgYWN0aXZlIGNvcmVzCjIzICogODMuMyA9IDE5MTUuOSBNSHogbWF4IHR1cmJvIDIgYWN0aXZl
IGNvcmVzCjIzICogODMuMyA9IDE5MTUuOSBNSHogbWF4IHR1cmJvIDEgYWN0aXZlIGNvcmUKY3B1
MjogTVNSX1BLR19DU1RfQ09ORklHX0NPTlRST0w6IDB4MDAxNzAwMGYgKFVObG9ja2VkOiBwa2ct
Y3N0YXRlLWxpbWl0PTE1OiBwYzcpCmNwdTI6IFBPTEw6IENQVUlETEUgQ09SRSBQT0xMIElETEUK
Y3B1MjogQzE6IE1XQUlUIDB4MDAKY3B1MjogQzZOOiBNV0FJVCAweDU4CmNwdTI6IEM2UzogTVdB
SVQgMHg1MgpjcHUyOiBjcHVmcmVxIGRyaXZlcjogaW50ZWxfcHN0YXRlCmNwdTI6IGNwdWZyZXEg
Z292ZXJub3I6IHBlcmZvcm1hbmNlCmNwdWZyZXEgaW50ZWxfcHN0YXRlIG5vX3R1cmJvOiAxCmNw
dTA6IE1TUl9JQTMyX0VORVJHWV9QRVJGX0JJQVM6IDB4MDAwMDAwMDYgKGJhbGFuY2VkKQpjcHUw
OiBNU1JfUkFQTF9QT1dFUl9VTklUOiAweDAwMDAwNTA1ICgwLjAzMTI1MCBXYXR0cywgMC4wMDAw
MzIgSm91bGVzLCAwLjAwMDk3NyBzZWMuKQpjcHUwOiBNU1JfUEtHX1BPV0VSX0xJTUlUOiAweDAw
Mzg4MGZhIChVTmxvY2tlZCkKY3B1MDogUEtHIExpbWl0ICMxOiBFTmFibGVkICg3LjgxMjUwMCBX
YXR0cywgMjYyMTQ0LjAwMDAwMCBzZWMsIGNsYW1wIERJU2FibGVkKQpjcHUwOiBQS0cgTGltaXQg
IzI6IERJU2FibGVkICgwLjAwMDAwMCBXYXR0cywgMC4wMDA5NzcqIHNlYywgY2xhbXAgRElTYWJs
ZWQpCmNwdTA6IE1TUl9QUDBfUE9XRVJfTElNSVQ6IDB4MDAwMjAwMDAgKFVObG9ja2VkKQpjcHUw
OiBDb3JlcyBMaW1pdDogRElTYWJsZWQgKDAuMDAwMDAwIFdhdHRzLCAwLjAwMTk1MyBzZWMsIGNs
YW1wIERJU2FibGVkKQpjcHUwOiBNU1JfSUEzMl9URU1QRVJBVFVSRV9UQVJHRVQ6IDB4MDA2ZTAw
MDAgKDExMCBDKQo0MC4wMDM4MDcgc2VjCkNvcmUJQ1BVCUF2Z19NSHoJQnVzeSUJQnp5X01IeglU
U0NfTUh6CUlSUQlTTUkJQzEJQzZOCUM2UwlDMSUJQzZOJQlDNlMlCUNQVSVjMQlDUFUlYzYJTW9k
JWM2CUNvcmVUbXAJR0ZYJXJjNglQa2clcGM2CVBrZ1dhdHQJQ29yV2F0dAotCS0JNTIyCTI3LjIz
CTE5MTUJMTkxNwkyODUwNzQJMAk3ODQxMzIJODYzMzYJMTY4MjM1CTMxLjE3CTEzLjQxCTI4Ljg5
CTMwLjc1CTI2Ljk3CTMuNzUJMzAJMTAwLjAwCTMuNjAJMS4xMgkwLjk0CjAJMAk0MTIJMjEuNTAJ
MTkxNQkxOTE3CTExMjI5CTAJMTU1ODQwCTEzMjI5CTY5NzQ2CTI0LjY4CTcuOTUJNDYuNTcJMjQu
MzUJMzUuMjgJMy44MAkyOQkxMDAuMDAJMy42MAkxLjEyCTAuOTQKMQkxCTc2NAkzOS45MQkxOTE0
CTE5MTcJMjQyNjQ5CTAJMjY5OTI1CTI1MTc5CTMyNDE4CTI2Ljk1CTEzLjQ0CTIwLjUyCTI2LjM4
CTE5LjI2CTMuODAJMjkKMgkyCTQ3NgkyNC44MgkxOTE1CTE5MTcJMTY1NDkJMAkyMjQzNzcJMjc4
MzkJMTI2OQk0OC44NQkyMS41Mgk1LjQ0CTQ4LjM2CTE5LjA0CTMuNzAJMzAKMwkzCTQzNQkyMi43
MAkxOTE1CTE5MTcJMTQ2NDcJMAkxMzM5OTAJMjAwODkJNjQ4MDIJMjQuMTkJMTAuNzQJNDMuMDUJ
MjMuOTAJMzQuMjgJMy43MAkzMAo=
--000000000000f4a3f505ae2ed049--
