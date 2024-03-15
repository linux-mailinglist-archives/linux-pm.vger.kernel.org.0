Return-Path: <linux-pm+bounces-4976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9FE87CB24
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 11:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22151C21105
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FD9182A7;
	Fri, 15 Mar 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=post.cz header.i=@post.cz header.b="NS5SVTZv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8496FD0
	for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497375; cv=none; b=UJv22sf6mmIJPWM1iwsHt5FwCmSLrxQ7U9K3Swl/uZwsvezLHz8f4gbWYtz22Hpf1eJpXAWquIhmTqmASVMmAdOadNYVkbQqiNFWXXni+oFJzYdrO0hBpYaxlRlFeY7yD9/fw5VZaB51Pu4zY/1JJPyXpAOL3tKFH3xy9pN3c4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497375; c=relaxed/simple;
	bh=1ZLMB7ONQIFZ5Gi4eeFGiys/z45JJZRhaPMfpimQXBg=;
	h=From:To:Date:MIME-Version:Content-type:Subject:Message-ID; b=lorp47VyzkzTQxA6/cFw5T4TCvjTYx+pLycAGfxTqhYaqtUUirl0fNcYmQ8aWXG+sx5fmHeASIJFUSBeaA3URRlO1LitqUKcN+IaEPzH/B3pQ/5F3juNKLCLaPrdhyMEZtO7X0ZrC2wvK7L0bIuPQBkz6yadFsmtlpPPZQKY8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=post.cz; spf=pass smtp.mailfrom=post.cz; dkim=pass (2048-bit key) header.d=post.cz header.i=@post.cz header.b=NS5SVTZv; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=post.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=post.cz
Received: from email.seznam.cz
	by smtpc-mxd-5f6fbc55db-mfbsh
	(smtpc-mxd-5f6fbc55db-mfbsh [2a02:598:128:8a00::1000:a5a])
	id 4de1c8189a5a717d4d49d6df;
	Fri, 15 Mar 2024 11:09:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=post.cz;
	s=szn20221014; t=1710497364;
	bh=pFwn2QIBk+xaj28StQztr67J12PuuNx+6hSpe+XCUdY=;
	h=Received:From:To:Date:MIME-Version:Content-type:Subject:
	 Message-ID:Priority:X-mailer;
	b=NS5SVTZvOUp5ejPjr1ia7h4u0js9JgCl8Gw+t06kbrAWZ/5UQqo125Lz5fU36HYi+
	 P3WU41c8t5/oxMnMp79cQQyq8RMfkNo06W8ss5VmJ95k3In9JbEK5c8lCARXLevpLW
	 yJoGQPleFLjs6nhBdXs6/zFCi3NC0MbD90BVI78ijgYjApiCiGuavRLroCspvRazUu
	 9bv6wEDGa8k625nMjZ1alle/7ufJguRuniw3sNFnfQo05d+jPPgrxvJsB31Eql/2PE
	 PbazPlpB/5r8TqHswC//sJR5lFeJ1Vxtvqc/1XgbW5o559IL1na7BaM3XWZZAqSllI
	 uJCU87M1oc+7g==
Received: from [192.168.88.10] (250.68.pool1.tetanet.cz [109.202.68.250])
	by smtpd-relay-594d8f6859-ktnhf (szn-email-smtpd/2.0.18) with ESMTPA
	id a86a2ee6-0d56-4fd4-8424-faa0384c8e63;
	Fri, 15 Mar 2024 11:09:22 +0100
From: "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
To: linux-pm@vger.kernel.org
Date: Fri, 15 Mar 2024 11:09:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-12014
Subject: Re: turbostat does not indicate throttling on a Raptor Lake CPU
Message-ID: <65F41E51.20530.BE5AA6E@Frantisek.Rysanek.post.cz>
Priority: normal
X-mailer: Pegasus Mail for Windows (4.81.1154)


--Message-Boundary-12014
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

Hello again folks,

I have probably made up my mind a little - on several items.

Firstly, I've included the raw IA32_THERM_STATUS msr 0x19C and 
IA32_HWP_STATUS_MSR 0x777 in my turbostat output (hopefully see it 
attached again).

In the IA32_THERM_STATUS, I can see the raw value from the coretemp 
sensor, I can see how it correlates to the CoreTmp value as 
interpreted by turbostat = the raw value is a difference from 
IA32_TEMPERATURE_TARGET (as reported by turbostat in the leading 
summary "header section" of the dump). = Degrees centigrade left to 
the target, apparently a positive integer (I haven't seen the 
temperature ever exceed the target, therefore I do not know if the 
raw value is possibly signed).

In the IA32_THERM_STATUS, I can also see some bitwise flags.
Namely, only when the temperature reaches the target (100*C) do the 
Thermal Threshold bits #1 and #2 (current values) become log.1, and 
at the same time the Thermal Status (bit 0 in the MSR) becomes 1 as 
well. The "log" companions of those three bits remain at log.1 if 
that particular "cpu=thread" has reached the temperature target since 
reset.

I.e. there's a "Thermal Status" bit in IA32_THERM_STATUS.0 per 
cpu=thread.
In chapter 15.8.5.2, its meaning is described this way:
"This bit indicates whether the digital thermal sensor 
high-temperature output signal (PROCHOT#) is currently active. Bit 0 
= 1 indicates the feature is active. This bit may not be written by
software; it reflects the state of the digital thermal sensor."

There's also a "Thermal Status" bit in MSR_CORE_PERF_LIMIT_REASONS.1 
per package, explaine in this way:
"When set, frequency is reduced below the operating system request 
due to a thermal event."

There are other bits in those two registers, referring specifically 
to the PROCHOT signal - but, from their descriptions it is clear that 
these are related specifically to external PROCHOT input, i.e. NOT 
the on-die coretemp sensors. That is why these other PROCHOT flags 
are off in my CPU.

So, I can see indications that the CPU has reached the "TARGET" 
temperature of 100*C, which is synonymous to raising the internal, 
coretemp-based, PROCHOT condition.
I have seen no indications that this has been exceeded further.

And, I have no clue if this already means that a T-state was engaged, 
or not. Whenever I refer to "throttling", I mean precisely a T-state 
i.e. PWM-style clock gating. I don't necessarily expect to see any 
hints in terms of CLOCKMOD in the narrow sense, referring to the 
precambrian CLOCKMOD-related MSR's. There was a bug in (some series 
of the?) the Haswell CPU's, where the CPU was in fact throttling for 
no good reason, and this did not get reflected in the 
IA32_CLOCK_MODULATION MSR.
The bug did raise one flag in the MSR_CORE_PERF_LIMIT_REASONS (I 
don't recall which one anymore).

I cannot exclude the possibility that a T-state is not in fact 
engaged in the hardware on my desk today, and that all we have is an 
indication that the "target temperature" gets just gently caressed 
from below, using careful choice of a P-state and by fan speed servo 
(courtesy of the autonomous control loop on part of the SuperIO 
chip).
We have in fact observed the frequencies and consumption gradually 
decrease, and fan speed increase, as the target temperature got 
slowly reached under maximum CPU load.
If that's in fact my case, I still have no clue how a T-state would 
be visible in the MSR's and in the turbostat output :-)

Maybe this could be inferred by regularly sampling CPU_CLK_UNHALTED 
(delta) and comparing to the TSC (delta). Not sure if time spent in 
C-states >0 also affects that counter. Not sure if/how the Avg_MHz 
and Bzy_MHz is related.

I'm not going to try to impair my cooling somehow catastrophically 
just to test this.

With that hypothesis, I'm probably going to close the topic.
The machine is going to depart our workshop on Monday.

Any further comments would be welcome :-)
Thanks for your attention.

Frank

> Dear Linux devs and fellow users,
> 
> first of all thanks for the great job that you're doing.
> Specifically, I'd like to thank Len Brown for coding the turbostat 
> utility (I hope I understand correctly that he is the principal 
> author). Also I'd like to confess that I'm a fan of Intel, and that I 
> prefer the lowest-end models in terms of power consumption. 
> Therefore, the topic of this message is a bit of a foreign territory 
> to me :-)
> 
> I like using Linux to test PC hardware, and every once in a while I 
> have an opportunity to inspect an actual culprit. And, this is 
> approx. my second occasion where thermals and throttling are in the 
> game (and I have a bit of a clue of what I'm doing.)
> 
> On a previous occasion, I've done my homework (study) about what the 
> various P-states, C-states and C-states are about. That was roughly 
> about Haswell to Skylake time. This is when I sketched this picture:
> http://support.fccps.cz/industry/pwr/cube.png
> (My earlier poking at the EIST MSR's doesn't seem very relevant 
> today.)
> 
> Yes I was trying to troubleshoot a piece of Haswell hardware, and 
> that's where I became aware of the turbostat, among other software in 
> this vein. And, since then I remember one particular MSR that has 
> proven quite helpful to me:
> MSR_CORE_PERF_LIMIT_REASONS
> 
> I know that after Haswell and Skylake, power management R&D at Intel 
> went on :-) The steering of the P-states has moved from OS control to 
> HW control, and has become further fine-grained, and whatnot.
> I lost track.
> 
> Now I happen to have a machine in our workshop, based on the Intel 
> i7-13700K. Yes, a K-model, the unlocked beast, of the relatively 
> recent Raptor Lake generation. I've been past my age of the GHz race 
> for decades now :-) My interest in the setup is more professional / 
> academic. I'd like to update / fine-tune my tools and knowledge, for 
> analyzing the borderline thermal states that this machine seems to be 
> demonstrating. (You know - the machines that normally pass through my 
> hands preferably never reach 50*C on the die.)
> Shoud some PC setup pass through my hands, where the thermals are 
> genuinely awry and not intentionally so, I'd need to see what's going 
> on, I'd like to have the tools ready (as much as possible and fair to 
> ask).
> 
> So... I PXE-booted my Debian-based diskless testbed, ran some 
> multithreaded CPU benchmark to stress the CPU, waited for the fans to 
> spin up, and kept watching from inside using turbostat, to see where 
> some warnings about overheating start popping up. The machine has a 
> pretty decent CPU heatsink, which however still lacks a bit of 
> cooling power, compared to the immodest CPU TDP. And indeed, after a 
> couple of minutes the CPU started hitting the TJmax expected at 
> 100*C. For the purposes of this test, this is intended.
> (I don't tease the CPU and VRM for very long.)
> 
> Curiously to me, I don't see any grave warnings in the turbostat.
> I can see the temperatures just lick 100*C from below, I can see the 
> frequencies (P-state) backing off a little, but... no signs of the 
> wretched T-state.
> In particular, turbostat doesn't seem to be reporting the 
> MSR_CORE_PERF_LIMIT_REASONS
> to me.
> I was wondering why that is. Has this MSR fallen out of favour, with 
> the more recent CPU generations? Does it even still exist?
> 
> Turns out, that yes it does exist.
> I could reach it using the "msr-tools", but in fact turbostat itself 
> can be asked to follow a particular "custom" MSR for me. Such as:
> 
> turbostat --add msr0x64F,u32,raw,package,LMT_RSN
> 
> I'll try to attach a 9kB turbostat.log to this message (not sure if 
> the mailing list accepts that). The point is, that the MSR seems to 
> return a value of 0x10020002 , which can be interpreted as:
> - since the last reset, there have been some instances of overheat 
> and "curbing the turbo frequencies"
> - I am "limiting performance" for temperature reasons right now!
> 
> Does that trailing "2" (bit 1 = ON) indicate a T-state active?
> 
> Originally I used the Turbostat present in Debian 11, which is 
> v20.09.30. Later today I downloaded the latest release of Turbostat 
> and compiled it from source code. That's 2023.11.07.
> My questions and the attached dump/log file are based on this latest 
> version.
> 
> Does the output of the latest Turbostat give any other hint that 
> throttling is on?
> 
> Are there any other MSR's I could take a look at?
> 
> I have noticed that HWinfo in Windows does report throttling, and 
> reports it "per CPU" (Turbostat parlance) = per thread (as per Intel 
> Architecture Software Developer's Manual). How do I get my hands on 
> that indication from Linux :-)
> 
> Any clues are welcome.
> Thanks for your polite attention.
> 
> Frank
> 
> 
> Attachments:
>   \\file\DATA2\vymena\FRR\turbostat.log



--Message-Boundary-12014
Content-type: text/plain; charset=US-ASCII
Content-disposition: inline
Content-description: Attachment information.

The following section of this message contains a file attachment
prepared for transmission using the Internet MIME message format.
If you are using Pegasus Mail, or any other MIME-compliant system,
you should be able to save it or view it from within your mailer.
If you cannot, please ask your system administrator for assistance.

   ---- File information -----------
     File:  turbostat_with_THERM_STATUS.log
     Date:  15 Mar 2024, 10:05
     Size:  10230 bytes.
     Type:  Unknown

--Message-Boundary-12014
Content-type: Application/Octet-stream; name="turbostat_with_THERM_STATUS.log"; type=Unknown
Content-disposition: attachment; filename="turbostat_with_THERM_STATUS.log"
Content-transfer-encoding: BASE64

IyB0dXJib3N0YXQgLS1hZGQgbXNyMHg2NEYsdTMyLHJhdyxwYWNrYWdlLExNVF9SU04gLS1h
ZGQgbXNyMHgxOUMsdTMyLHJhdyxjcHUsVEhSTV9TVEFUIC0tYWRkIG1zcjB4Nzc3LHUzMixy
YXcsY3B1LEhXUF9TVEFUCgp0dXJib3N0YXQgdmVyc2lvbiAyMDIzLjExLjA3IC0gTGVuIEJy
b3duIDxsZW5iQGtlcm5lbC5vcmc+Cktlcm5lbCBjb21tYW5kIGxpbmU6IGRlYjExYW1kNjQu
a2VybmVsIGluaXRyZD1kZWIxMWFtZDY0LmluaXRyZCBuZnNyb290PTE5Mi4xNjguMi40Oi92
YXIvTkZTYm9vdC9kZWIxMV94ODZfNjQgQk9PVElGPTAxLTc0LTU2LTNjLWU1LTc1LWEwIGlw
PWRoY3Agcm8gc3lzdGVtZC51bml0PWdyYXBoaWNhbC50YXJnZXQgbmV0LmlmbmFtZXM9MCBp
bnRlbF9pZGxlLm1heF9jc3RhdGU9MSBtaXRpZ2F0aW9ucz1vZmYgODI1MC5ucl91YXJ0cz0z
MgpDUFVJRCgwKTogR2VudWluZUludGVsIDB4MjAgQ1BVSUQgbGV2ZWxzCkNQVUlEKDEpOiBm
YW1pbHk6bW9kZWw6c3RlcHBpbmcgMHg2OmI3OjEgKDY6MTgzOjEpIG1pY3JvY29kZSAweDEx
ZApDUFVJRCgweDgwMDAwMDAwKTogbWF4X2V4dGVuZGVkX2xldmVsczogMHg4MDAwMDAwOApD
UFVJRCgxKTogU1NFMyBNT05JVE9SIFNNWCBFSVNUIFRNMiBUU0MgTVNSIEFDUEktVE0gSFQg
VE0KQ1BVSUQoNik6IEFQRVJGLCBUVVJCTywgRFRTLCBQVE0sIEhXUCwgSFdQbm90aWZ5LCBI
V1B3aW5kb3csIEhXUGVwcCwgSFdQcGtnLCBOby1FUEIKY3B1MDogTVNSX0lBMzJfTUlTQ19F
TkFCTEU6IDB4MDA4NTAwODkgKFRDQyBFSVNUIE1XQUlUIFBSRUZFVENIIFRVUkJPKQpDUFVJ
RCg3KTogTm8tU0dYIEh5YnJpZApDUFVJRCgweDE1KTogZWF4X2NyeXN0YWw6IDIgZWJ4X3Rz
YzogMTc4IGVjeF9jcnlzdGFsX2h6OiAzODQwMDAwMApUU0M6IDM0MTcgTUh6ICgzODQwMDAw
MCBIeiAqIDE3OCAvIDIgLyAxMDAwMDAwKQpDUFVJRCgweDE2KTogYmFzZV9taHo6IDM0MDAg
bWF4X21oejogNTQwMCBidXNfbWh6OiAxMDAKY3B1MDogTVNSX1BMQVRGT1JNX0lORk86IDB4
ODA4MDgzOGYxODEyMjAwCjggKiAxMDAuMCA9IDgwMC4wIE1IeiBtYXggZWZmaWNpZW5jeSBm
cmVxdWVuY3kKMzQgKiAxMDAuMCA9IDM0MDAuMCBNSHogYmFzZSBmcmVxdWVuY3kKY3B1MDog
TVNSX1RVUkJPX1JBVElPX0xJTUlUOiAweDM1MzUzNTM1MzUzNTM2MzYKNTMgKiAxMDAuMCA9
IDUzMDAuMCBNSHogbWF4IHR1cmJvIDggYWN0aXZlIGNvcmVzCjUzICogMTAwLjAgPSA1MzAw
LjAgTUh6IG1heCB0dXJibyA3IGFjdGl2ZSBjb3Jlcwo1MyAqIDEwMC4wID0gNTMwMC4wIE1I
eiBtYXggdHVyYm8gNiBhY3RpdmUgY29yZXMKNTMgKiAxMDAuMCA9IDUzMDAuMCBNSHogbWF4
IHR1cmJvIDUgYWN0aXZlIGNvcmVzCjUzICogMTAwLjAgPSA1MzAwLjAgTUh6IG1heCB0dXJi
byA0IGFjdGl2ZSBjb3Jlcwo1MyAqIDEwMC4wID0gNTMwMC4wIE1IeiBtYXggdHVyYm8gMyBh
Y3RpdmUgY29yZXMKNTQgKiAxMDAuMCA9IDU0MDAuMCBNSHogbWF4IHR1cmJvIDIgYWN0aXZl
IGNvcmVzCjU0ICogMTAwLjAgPSA1NDAwLjAgTUh6IG1heCB0dXJibyAxIGFjdGl2ZSBjb3Jl
cwpjcHUwOiBNU1JfU0VDT05EQVJZX1RVUkJPX1JBVElPX0xJTUlUOiAweDJhMmEyYTJhMmEy
YTJhMmEKNDIgKiAxMDAuMCA9IDQyMDAuMCBNSHogbWF4IHR1cmJvIDggYWN0aXZlIGNvcmVz
CjQyICogMTAwLjAgPSA0MjAwLjAgTUh6IG1heCB0dXJibyA3IGFjdGl2ZSBjb3Jlcwo0MiAq
IDEwMC4wID0gNDIwMC4wIE1IeiBtYXggdHVyYm8gNiBhY3RpdmUgY29yZXMKNDIgKiAxMDAu
MCA9IDQyMDAuMCBNSHogbWF4IHR1cmJvIDUgYWN0aXZlIGNvcmVzCjQyICogMTAwLjAgPSA0
MjAwLjAgTUh6IG1heCB0dXJibyA0IGFjdGl2ZSBjb3Jlcwo0MiAqIDEwMC4wID0gNDIwMC4w
IE1IeiBtYXggdHVyYm8gMyBhY3RpdmUgY29yZXMKNDIgKiAxMDAuMCA9IDQyMDAuMCBNSHog
bWF4IHR1cmJvIDIgYWN0aXZlIGNvcmVzCjQyICogMTAwLjAgPSA0MjAwLjAgTUh6IG1heCB0
dXJibyAxIGFjdGl2ZSBjb3JlcwpjcHUwOiBNU1JfQ09ORklHX1REUF9OT01JTkFMOiAweDAw
MDAwMDIyIChiYXNlX3JhdGlvPTM0KQpjcHUwOiBNU1JfQ09ORklHX1REUF9MRVZFTF8xOiAw
eDAwMDAwMDAwICgpCmNwdTA6IE1TUl9DT05GSUdfVERQX0xFVkVMXzI6IDB4MDAwMDAwMDAg
KCkKY3B1MDogTVNSX0NPTkZJR19URFBfQ09OVFJPTDogMHg4MDAwMDAwMCAoIGxvY2s9MSkK
Y3B1MDogTVNSX1RVUkJPX0FDVElWQVRJT05fUkFUSU86IDB4MDAwMDAwMDAgKE1BWF9OT05f
VFVSQk9fUkFUSU89MCBsb2NrPTApCmNwdTA6IGNwdWZyZXEgZHJpdmVyOiBpbnRlbF9wc3Rh
dGUKY3B1MDogY3B1ZnJlcSBnb3Zlcm5vcjogcG93ZXJzYXZlCmNwdWZyZXEgaW50ZWxfcHN0
YXRlIG5vX3R1cmJvOiAwCmNwdTA6IE1TUl9NSVNDX1BXUl9NR01UOiAweDAwMDAzMGMyIChF
TmFibGUtRUlTVF9Db29yZGluYXRpb24gRU5hYmxlLUVQQiBESVNhYmxlLU9PQikKY3B1MDog
TVNSX1BNX0VOQUJMRTogMHgwMDAwMDAwMSAoSFdQKQpjcHUwOiBNU1JfSFdQX0NBUEFCSUxJ
VElFUzogMHgwMTE2MmM0NCAoaGlnaCA2OCBndWFyIDQ0IGVmZiAyMiBsb3cgMSkKY3B1MDog
TVNSX0hXUF9SRVFVRVNUOiAweDgwMDA0NDA4IChtaW4gOCBtYXggNjggZGVzIDAgZXBwIDB4
ODAgd2luZG93IDB4MCBwa2cgMHgwKQpjcHUwOiBNU1JfSFdQX1JFUVVFU1RfUEtHOiAweDgw
MDBmZjAxIChtaW4gMSBtYXggMjU1IGRlcyAwIGVwcCAweDgwIHdpbmRvdyAweDApCmNwdTA6
IE1TUl9IV1BfSU5URVJSVVBUOiAweDAwMDAwMDAwIChEaXNfR3VhcmFudGVlZF9QZXJmX0No
YW5nZSwgRGlzX0V4Y3Vyc2lvbl9NaW4pCmNwdTA6IE1TUl9IV1BfU1RBVFVTOiAweDAwMDAw
MDAwIChOby1HdWFyYW50ZWVkX1BlcmZfQ2hhbmdlLCBOby1FeGN1cnNpb25fTWluKQpjcHUw
OiBNU1JfSUEzMl9QT1dFUl9DVEw6IDB4MDBmODAwNWYgKEMxRSBhdXRvLXByb21vdGlvbjog
RU5hYmxlZCkKY3B1MDogTVNSX1BLR19DU1RfQ09ORklHX0NPTlRST0w6IDB4NzQwMDAwMDAg
KFVOZGVtb3RlLUMxLCBkZW1vdGUtQzEsIFVObG9ja2VkLCBwa2ctY3N0YXRlLWxpbWl0PTAg
KHBjMCkpCi9kZXYvY3B1X2RtYV9sYXRlbmN5OiAyMDAwMDAwMDAwIHVzZWMgKGRlZmF1bHQp
CmN1cnJlbnRfZHJpdmVyOiBpbnRlbF9pZGxlCmN1cnJlbnRfZ292ZXJub3I6IG1lbnUKY3Vy
cmVudF9nb3Zlcm5vcl9ybzogbWVudQpjcHUwOiBQT0xMOiBDUFVJRExFIENPUkUgUE9MTCBJ
RExFCmNwdTA6IEMxQUNQSTogQUNQSSBGRkggTVdBSVQgMHgwCmNwdTA6IE1TUl9QS0dDM19J
UlRMOiAweDAwMDAwMDAwIChOT1R2YWxpZCwgMCBucykKY3B1MDogTVNSX1BLR0M2X0lSVEw6
IDB4MDAwMDAwMDAgKE5PVHZhbGlkLCAwIG5zKQpjcHUwOiBNU1JfUEtHQzhfSVJUTDogMHgw
MDAwMDAwMCAoTk9UdmFsaWQsIDAgbnMpCmNwdTA6IE1TUl9QS0dDMTBfSVJUTDogMHgwMDAw
MDAwMCAoTk9UdmFsaWQsIDAgbnMpClJBUEw6IDIwOTcgc2VjLiBKb3VsZSBDb3VudGVyIFJh
bmdlLCBhdCAxMjUgV2F0dHMKY3B1MDogTVNSX1JBUExfUE9XRVJfVU5JVDogMHgwMDBhMGUw
MyAoMC4xMjUwMDAgV2F0dHMsIDAuMDAwMDYxIEpvdWxlcywgMC4wMDA5Nzcgc2VjLikKY3B1
MDogTVNSX1BLR19QT1dFUl9JTkZPOiAweDAwMDAwM2U4ICgxMjUgVyBURFAsIFJBUEwgMCAt
IDAgVywgMC4wMDAwMDAgc2VjLikKY3B1MDogTVNSX1BLR19QT1dFUl9MSU1JVDogMHg0M2Zm
ZjgwMDFiZmZmOCAoVU5sb2NrZWQpCmNwdTA6IFBLRyBMaW1pdCAjMTogRU5hYmxlZCAoNDA5
NS4wMDAgV2F0dHMsIDguMDAwMDAwIHNlYywgY2xhbXAgRU5hYmxlZCkKY3B1MDogUEtHIExp
bWl0ICMyOiBFTmFibGVkICg0MDk1LjAwMCBXYXR0cywgMC4wMDI0NDEqIHNlYywgY2xhbXAg
RU5hYmxlZCkKY3B1MDogTVNSX1ZSX0NVUlJFTlRfQ09ORklHOiAweDAwMDAwMDAwCmNwdTA6
IFBLRyBMaW1pdCAjNDogMC4wMDAwMDAgV2F0dHMgKFVObG9ja2VkKQpjcHUwOiBNU1JfRFJB
TV9QT1dFUl9MSU1JVDogMHgxNGZmZjgwMDE0ZmZmOCAoVU5sb2NrZWQpCmNwdTA6IERSQU0g
TGltaXQ6IEVOYWJsZWQgKDQwOTUuMDAwIFdhdHRzLCAxLjAwMDAwMCBzZWMsIGNsYW1wIERJ
U2FibGVkKQpjcHUwOiBNU1JfUFAwX1BPTElDWTogMApjcHUwOiBNU1JfUFAwX1BPV0VSX0xJ
TUlUOiAweDAwMDAwMDAwIChVTmxvY2tlZCkKY3B1MDogQ29yZXMgTGltaXQ6IERJU2FibGVk
ICgwLjAwMCBXYXR0cywgMC4wMDA5Nzcgc2VjLCBjbGFtcCBESVNhYmxlZCkKY3B1MDogTVNS
X1BQMV9QT0xJQ1k6IDAKY3B1MDogTVNSX1BQMV9QT1dFUl9MSU1JVDogMHgwMDAwMDAwMCAo
VU5sb2NrZWQpCmNwdTA6IEdGWCBMaW1pdDogRElTYWJsZWQgKDAuMDAwIFdhdHRzLCAwLjAw
MDk3NyBzZWMsIGNsYW1wIERJU2FibGVkKQpjcHUwOiBNU1JfSUEzMl9URU1QRVJBVFVSRV9U
QVJHRVQ6IDB4ODA2NDE0MDAgKDEwMCBDKSAoMTAwIGRlZmF1bHQgLSAwIG9mZnNldCkKY3B1
MDogTVNSX0lBMzJfUEFDS0FHRV9USEVSTV9TVEFUVVM6IDB4ODgwMDAzYzMgKDEwMCBDKQpj
cHUwOiBNU1JfSUEzMl9QQUNLQUdFX1RIRVJNX0lOVEVSUlVQVDogMHgwMDAwMDAwMyAoMTAw
IEMsIDEwMCBDKQpjcHUwOiBNU1JfTUlTQ19GRUFUVVJFX0NPTlRST0w6IDB4MDAwMDAwMDAg
KEwyLVByZWZldGNoIEwyLVByZWZldGNoLXBhaXIgTDEtUHJlZmV0Y2ggTDEtSVAtUHJlZmV0
Y2gpCkNvcmUJQ1BVCUF2Z19NSHoJQnVzeSUJQnp5X01IeglUU0NfTUh6CUlQQwlJUlEJU01J
CVBPTEwJQzFBQ1BJCVBPTEwlCUMxQUNQSSUJICBIV1BfU1RBVAkgVEhSTV9TVEFUCUNQVSVj
MQlDUFUlYzYJQ1BVJWM3CUNvcmVUbXAJQ29yZVRocglQa2dUbXAJVG90bCVDMAlBbnklQzAJ
R0ZYJUMwCUNQVUdGWCUJUGtnV2F0dAlDb3JXYXR0CUdGWFdhdHQJUkFNV2F0dAlQS0dfJQlS
QU1fJQkgICBMTVRfUlNOCi0JLQk0MTQ0CTk5LjQ1CTQxNjcJMzQxOAkyLjA5CTMwNTYzMAkw
CTc3NzgwCTQ3OTY1CTAuMTQJMC41OAkweDAwMDAwMDAwCTB4MDAwMDAwMDAJMC4wMAkwLjAw
CTAuMDAJMTAwCTg4MTg2CTEwMAkxNjA4LjMxCTEwMC41MgkwLjAwCTAuMDAJMTgzLjQzCTE4
MS42MQkwLjAwCTAuMDAJMC4wMAkwLjAwCTB4MDAwMDAwMDAKMAkwCTQ0NTYJOTkuMjYJNDQ4
OQkzNDE4CTIuMzUJOTIwNwkwCTYxNDkJMTM3MAkwLjE1CTAuNzYJMHgwMDAwMDAwMAkweDg4
MDcwMDAwCTAuMDAJMC4wMAkwLjAwCTkzCTAJMTAwCTE2MDguMjkJMTAwLjUyCTAuMDAJMC4w
MAkxODMuNDIJMTgxLjYwCTAuMDAJMC4wMAkwLjAwCTAuMDAJMHgxMDAyMDAwMgowCTEJNDQ4
MQk5OS44MQk0NDg5CTM0MTgJMi4zNAkxMTY4MAkwCTQxMTUJMTEwOQkwLjEzCTAuMjEJMHgw
MDAwMDAwMAkweDg4MDcwMDAwCTAuMDAKNAkyCTQ0NTgJOTkuMjkJNDQ5MAkzNDE4CTIuMzYJ
ODMzOAkwCTQ3MzUJMTA5OAkwLjEyCTAuNzMJMHgwMDAwMDAwMAkweDg4MDMwMjgwCTAuMDAJ
MC4wMAkwLjAwCTk3CTI1MzgKNAkzCTQ0ODcJOTkuOTQJNDQ4OQkzNDE4CTIuMzcJOTU4OQkw
CTUxNDEJMTAzNwkwLjEzCTAuMDgJMHgwMDAwMDAwMAkweDg4MDMwMjgwCTAuMDAKOAk0CTQ0
ODQJOTkuODkJNDQ4OQkzNDE4CTIuMzUJODg2OQkwCTM4ODkJNzQ0CTAuMTAJMC4xMwkweDAw
MDAwMDAwCTB4ODgwMjAyODAJMC4wMAkwLjAwCTAuMDAJOTgJODc4Mgo4CTUJNDQ2MQk5OS4z
OAk0NDg5CTM0MTgJMi4zNQkxMDE4OQkwCTQ5NjAJODEyCTAuMTMJMC42NAkweDAwMDAwMDAw
CTB4ODgwMjAyODAJMC4wMAoxMgk2CTQ0NzIJOTkuNjEJNDQ4OQkzNDE4CTIuMjkJMTc2MzUJ
MAk2MjIxCTE5OTcJMC4yNQkwLjQxCTB4MDAwMDAwMDAJMHg4ODAyMDI4MAkwLjAwCTAuMDAJ
MC4wMAk5OAk1NzQwCjEyCTcJNDQ1NQk5OS4yMwk0NDg5CTM0MTgJMi4zMwkxNjU5MwkwCTI4
OTYJNTA3MQkwLjIyCTAuODIJMHgwMDAwMDAwMAkweDg4MDIwMjgwCTAuMDAKMTYJOAk0NDgw
CTk5Ljc5CTQ0ODkJMzQxOAkyLjM1CTkyMjUJMAk2MDI3CTExNDUJMC4xNwkwLjIzCTB4MDAw
MDAwMDAJMHg4ODAyMDI4MgkwLjAwCTAuMDAJMC4wMAk5OAk3NzA2CjE2CTkJNDQ4MAk5OS44
MAk0NDg5CTM0MTgJMi4zNQkxMTg3MwkwCTQxNDUJMTIwNAkwLjEzCTAuMjMJMHgwMDAwMDAw
MAkweDg4MDIwMjgyCTAuMDAKMjAJMTAJNDQ3OAk5OS43Ngk0NDg5CTM0MTgJMi4zNgk5NTYz
CTAJNjQ2MwkxNTQ3CTAuMTgJMC4yNwkweDAwMDAwMDAwCTB4ODgwMDAzYzMJMC4wMAkwLjAw
CTAuMDAJMTAwCTg4MTg2CjIwCTExCTQ0ODEJOTkuODIJNDQ4OQkzNDE4CTIuMzUJMTIzNTkJ
MAkzNTQzCTE0OTQJMC4xMwkwLjIwCTB4MDAwMDAwMDAJMHg4ODAwMDNjMwkwLjAwCjI0CTEy
CTQ0NzIJOTkuNjIJNDQ4OQkzNDE4CTIuMzUJOTg2MwkwCTQ0NjkJMjIwMwkwLjE2CTAuNDEJ
MHgwMDAwMDAwMAkweDg4MDQwMjgyCTAuMDAJMC4wMAkwLjAwCTk2CTU4MjgKMjQJMTMJNDQ3
OAk5OS43NAk0NDg5CTM0MTgJMi4zNAkxNDEwMAkwCTUyMjIJMTUzNgkwLjE4CTAuMjgJMHgw
MDAwMDAwMAkweDg4MDQwMjgyCTAuMDAKMjgJMTQJNDI4NAk5NS40OAk0NDg4CTM0MTgJMi4w
NwkzOTE2NAkwCTQzNjgJMTE3OTAJMC40Mwk0LjYyCTB4MDAwMDAwMDAJMHg4ODA2MDI4MAkw
LjAwCTAuMDAJMC4wMAk5NAk0OTEKMjgJMTUJNDMyMAk5Ni4yNgk0NDg4CTM0MTgJMS45NAk4
NzE2MQkwCTU0MzcJMTM4MDgJMC43MgkzLjg1CTB4MDAwMDAwMDAJMHg4ODA2MDI4MAkwLjAw
CjMyCTE2CTM1MjkJMTAwLjAyCTM1MjgJMzQxOAkxLjU0CTI0OTkJMAkwCTAJMC4wMAkwLjAw
CTB4MDAwMDAwMDAJMHg4ODA4MDAwMAkwLjAwCTAuMDAJMC4wMAk5MgkwCjMzCTE3CTM1MjkJ
MTAwLjAyCTM1MjgJMzQxOAkxLjU0CTI0OTgJMAkwCTAJMC4wMAkwLjAwCTB4MDAwMDAwMDAJ
MHg4ODA4MDAwMAkwLjAwCTAuMDAJMC4wMAk5MgkwCjM0CTE4CTM1MjkJMTAwLjAyCTM1MjgJ
MzQxOAkxLjU0CTI1NzYJMAkwCTAJMC4wMAkwLjAwCTB4MDAwMDAwMDAJMHg4ODA4MDAwMAkw
LjAwCTAuMDAJMC4wMAk5MgkwCjM1CTE5CTM1MjkJMTAwLjAyCTM1MjgJMzQxOAkxLjU0CTI0
OTcJMAkwCTAJMC4wMAkwLjAwCTB4MDAwMDAwMDAJMHg4ODA4MDAwMAkwLjAwCTAuMDAJMC4w
MAk5MgkwCjM2CTIwCTM1MzAJMTAwLjAyCTM1MjkJMzQxOAkxLjU0CTI1MDIJMAkwCTAJMC4w
MAkwLjAwCTB4MDAwMDAwMDAJMHg4ODBhMDAwMAkwLjAwCTAuMDAJMC4wMAk5MAkwCjM3CTIx
CTM1MzAJMTAwLjAyCTM1MjkJMzQxOAkxLjU0CTI1MTcJMAkwCTAJMC4wMAkwLjAwCTB4MDAw
MDAwMDAJMHg4ODBhMDAwMAkwLjAwCTAuMDAJMC4wMAk5MAkwCjM4CTIyCTM1MzAJMTAwLjAy
CTM1MjkJMzQxOAkxLjU0CTI0OTkJMAkwCTAJMC4wMAkwLjAwCTB4MDAwMDAwMDAJMHg4ODBh
MDAwMAkwLjAwCTAuMDAJMC4wMAk5MAkwCjM5CTIzCTM1MzAJMTAwLjAyCTM1MjkJMzQxOAkx
LjU0CTI2MzQJMAkwCTAJMC4wMAkwLjAwCTB4MDAwMDAwMDAJMHg4ODBhMDAwMAkwLjAwCTAu
MDAJMC4wMAk5MAkwCkNvcmUJQ1BVCUF2Z19NSHoJQnVzeSUJQnp5X01IeglUU0NfTUh6CUlQ
QwlJUlEJU01JCVBPTEwJQzFBQ1BJCVBPTEwlCUMxQUNQSSUJICBIV1BfU1RBVAkgVEhSTV9T
VEFUCUNQVSVjMQlDUFUlYzYJQ1BVJWM3CUNvcmVUbXAJQ29yZVRocglQa2dUbXAJVG90bCVD
MAlBbnklQzAJR0ZYJUMwCUNQVUdGWCUJUGtnV2F0dAlDb3JXYXR0CUdGWFdhdHQJUkFNV2F0
dAlQS0dfJQlSQU1fJQkgICBMTVRfUlNOCi0JLQk0MTQ2CTk5LjUwCTQxNjYJMzQxOAkyLjA5
CTMwMjg5OQkwCTc5MDk3CTQ4MTkzCTAuMTUJMC41MwkweDAwMDAwMDAwCTB4MDAwMDAwMDAJ
MC4wMAkwLjAwCTAuMDAJMTAwCTg4Nzc0CTEwMAkxNjA4LjI3CTEwMC41MgkwLjAwCTAuMDAJ
MTgzLjI3CTE4MS40NgkwLjAwCTAuMDAJMC4wMAkwLjAwCTB4MDAwMDAwMDAKMAkwCTQ0ODQJ
OTkuOTAJNDQ4OQkzNDE4CTIuMzUJODUwOAkwCTQxMzYJNjczCTAuMTAJMC4xMgkweDAwMDAw
MDAwCTB4ODgwNzAwMDAJMC4wMAkwLjAwCTAuMDAJOTMJMAkxMDAJMTYwOC4yOQkxMDAuNTIJ
MC4wMAkwLjAwCTE4My4yOAkxODEuNDYJMC4wMAkwLjAwCTAuMDAJMC4wMAkweDEwMDIwMDAy
CjAJMQk0NDg1CTk5LjkyCTQ0ODkJMzQxOAkyLjM1CTEwNTMxCTAJNjE2NAk1OTAJMC4xNAkw
LjEwCTB4MDAwMDAwMDAJMHg4ODA3MDAwMAkwLjAwCjQJMgk0NDc4CTk5Ljc2CTQ0ODkJMzQx
OAkyLjM1CTk4NTMJMAk1MjkwCTE1NzYJMC4xNQkwLjI3CTB4MDAwMDAwMDAJMHg4ODA1MDI4
MAkwLjAwCTAuMDAJMC4wMAk5NQkyNTU3CjQJMwk0NDgxCTk5LjgyCTQ0ODkJMzQxOAkyLjM1
CTEyOTk4CTAJNDEwOAkxNTIyCTAuMTMJMC4yMAkweDAwMDAwMDAwCTB4ODgwNTAyODAJMC4w
MAo4CTQJNDQ4Mgk5OS44NQk0NDg5CTM0MTgJMi4zNQk5MTE4CTAJMzIyNQk5ODUJMC4xMAkw
LjE3CTB4MDAwMDAwMDAJMHg4ODAzMDI4MgkwLjAwCTAuMDAJMC4wMAk5Nwk4ODUxCjgJNQk0
NDgzCTk5Ljg5CTQ0ODkJMzQxOAkyLjM1CTExNjY0CTAJNjIwMQkxMDYwCTAuMTgJMC4xNAkw
eDAwMDAwMDAwCTB4ODgwMzAyODIJMC4wMAoxMgk2CTQ0NjUJOTkuNDcJNDQ4OAkzNDE4CTIu
MzAJMTcyNDQJMAk3ODg1CTE2MTAJMC4yOQkwLjU2CTB4MDAwMDAwMDAJMHg4ODAyMDI4Mgkw
LjAwCTAuMDAJMC4wMAk5OAk1NzY5CjEyCTcJNDQ1NQk5OS4yNQk0NDg4CTM0MTgJMi4zMwkx
NTE1NAkwCTE3NTQJNDgyNwkwLjE3CTAuODAJMHgwMDAwMDAwMAkweDg4MDIwMjgyCTAuMDAK
MTYJOAk0NDU0CTk5LjI1CTQ0ODgJMzQxOAkyLjI5CTEwMDUzCTAJNTUzOQkzMDEzCTAuMjYJ
MC43OQkweDAwMDAwMDAwCTB4ODgwMzAyODAJMC4wMAkwLjAwCTAuMDAJOTcJNzc3MAoxNgk5
CTQ0MjQJOTguNTcJNDQ4OAkzNDE4CTIuMzUJMTcyNDYJMAk0NjY0CTIwMzcJMC4xOAkxLjQ2
CTB4MDAwMDAwMDAJMHg4ODAzMDI4MAkwLjAwCjIwCTEwCTQ0NTgJOTkuMzQJNDQ4OAkzNDE4
CTIuMzMJMTA2NzkJMAk0MDc2CTI5NDIJMC4xOAkwLjcwCTB4MDAwMDAwMDAJMHg4ODAwMDNj
MwkwLjAwCTAuMDAJMC4wMAkxMDAJODg3NzQKMjAJMTEJNDQ1NQk5OS4yNgk0NDg4CTM0MTgJ
Mi4zMwkxODEyOQkwCTYxOTEJMjUzMwkwLjI0CTAuNzgJMHgwMDAwMDAwMAkweDg4MDAwM2Mz
CTAuMDAKMjQJMTIJNDQ2Nwk5OS41Mgk0NDg5CTM0MTgJMi4zMwkxMTUwMgkwCTQ1OTIJMjc1
MgkwLjIxCTAuNTIJMHgwMDAwMDAwMAkweDg4MDMwMjgyCTAuMDAJMC4wMAkwLjAwCTk3CTU4
NzEKMjQJMTMJNDQ3NQk5OS42OAk0NDg5CTM0MTgJMi4zMwkxODMwOQkwCTUzOTcJMjA2OAkw
LjIxCTAuMzQJMHgwMDAwMDAwMAkweDg4MDMwMjgyCTAuMDAKMjgJMTQJNDM0Mgk5Ni43NAk0
NDg4CTM0MTgJMi4xMAkzMDcxMwkwCTUwNjIJMTExODcJMC41MAkzLjM1CTB4MDAwMDAwMDAJ
MHg4ODA1MDI4MAkwLjAwCTAuMDAJMC4wMAk5NQk0OTIKMjgJMTUJNDM4NQk5Ny43MAk0NDg4
CTM0MTgJMi4xMgk3MTUxNwkwCTQ4MTMJODgxOAkwLjUyCTIuMzgJMHgwMDAwMDAwMAkweDg4
MDUwMjgwCTAuMDAKMzIJMTYJMzUyNgkxMDAuMDIJMzUyNQkzNDE4CTEuNTQJMjQ2NwkwCTAJ
MAkwLjAwCTAuMDAJMHgwMDAwMDAwMAkweDg4MDgwMDAwCTAuMDAJMC4wMAkwLjAwCTkyCTAK
MzMJMTcJMzUyNgkxMDAuMDIJMzUyNQkzNDE4CTEuNTQJMjQ0NwkwCTAJMAkwLjAwCTAuMDAJ
MHgwMDAwMDAwMAkweDg4MDgwMDAwCTAuMDAJMC4wMAkwLjAwCTkyCTAKMzQJMTgJMzUyNgkx
MDAuMDIJMzUyNQkzNDE4CTEuNTMJMjQ4MAkwCTAJMAkwLjAwCTAuMDAJMHgwMDAwMDAwMAkw
eDg4MDgwMDAwCTAuMDAJMC4wMAkwLjAwCTkyCTAKMzUJMTkJMzUyNgkxMDAuMDIJMzUyNQkz
NDE4CTEuNTMJMjQ1MwkwCTAJMAkwLjAwCTAuMDAJMHgwMDAwMDAwMAkweDg4MDgwMDAwCTAu
MDAJMC4wMAkwLjAwCTkyCTAKMzYJMjAJMzUyOQkxMDAuMDIJMzUyOQkzNDE4CTEuNTQJMjQ1
MwkwCTAJMAkwLjAwCTAuMDAJMHgwMDAwMDAwMAkweDg4MDkwMDAwCTAuMDAJMC4wMAkwLjAw
CTkxCTAKMzcJMjEJMzUyOQkxMDAuMDIJMzUyOQkzNDE4CTEuNTQJMjQ2NgkwCTAJMAkwLjAw
CTAuMDAJMHgwMDAwMDAwMAkweDg4MDkwMDAwCTAuMDAJMC4wMAkwLjAwCTkxCTAKMzgJMjIJ
MzUyOQkxMDAuMDIJMzUyOQkzNDE4CTEuNTIJMjQ2NgkwCTAJMAkwLjAwCTAuMDAJMHgwMDAw
MDAwMAkweDg4MDkwMDAwCTAuMDAJMC4wMAkwLjAwCTkxCTAKMzkJMjMJMzUyOQkxMDAuMDIJ
MzUyOQkzNDE4CTEuNTMJMjQ0OQkwCTAJMAkwLjAwCTAuMDAJMHgwMDAwMDAwMAkweDg4MDkw
MDAwCTAuMDAJMC4wMAkwLjAwCTkxCTAK

--Message-Boundary-12014--

