Return-Path: <linux-pm+bounces-4949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297EF87C132
	for <lists+linux-pm@lfdr.de>; Thu, 14 Mar 2024 17:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923821F21672
	for <lists+linux-pm@lfdr.de>; Thu, 14 Mar 2024 16:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13617316C;
	Thu, 14 Mar 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=post.cz header.i=@post.cz header.b="amR4iMLB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.78.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D97319F
	for <linux-pm@vger.kernel.org>; Thu, 14 Mar 2024 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433446; cv=none; b=sy4Pbgphg/2GK5y05gDRe+PUSojVQf+HirLsnXNz3jbq5IwxDIfAAYrF4AxF0cWdvWGtIio0Sdsr1Zz56J9e0i+P2uauxc0NKOwFuKvUhu2x8sg746WRLm0CuCoylwWmYoOZhieaQGVQWemjxXLhp2DRxnc73LqE0enwwyeOlhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433446; c=relaxed/simple;
	bh=twmaDRUegviGcDy83179B528tDXhULweQPqET2RCMaU=;
	h=From:To:Date:MIME-Version:Content-type:Subject:Message-ID; b=ZFNfkp1vemSifsrq5iNY5ybI0Nkv60HoBKI14zjM6hsKelz+/ffGKOEyiq5t+P1EYCMQWhmGxQthiy62qP1qz/+5ZvzLqcwSO+ud0Z/kXioAntNaJfZ0tiyS9ssSTwLL0PGDYLCh9BSKaGYbHUWfX5A/w5QcXjVuLwe80+sxNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=post.cz; spf=pass smtp.mailfrom=post.cz; dkim=pass (2048-bit key) header.d=post.cz header.i=@post.cz header.b=amR4iMLB; arc=none smtp.client-ip=77.75.78.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=post.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=post.cz
Received: from email.seznam.cz
	by smtpc-mxd-5f6fbc55db-mfbsh
	(smtpc-mxd-5f6fbc55db-mfbsh [2a02:598:128:8a00::1000:a5a])
	id 14c40163c37fb806146c1fa4;
	Thu, 14 Mar 2024 17:23:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=post.cz;
	s=szn20221014; t=1710433439;
	bh=MMoQAWokK2ddkVBmC+9oXpL3y4ilxjeul4Zl0PeYvMI=;
	h=Received:From:To:Date:MIME-Version:Content-type:Subject:
	 Message-ID:Priority:X-mailer;
	b=amR4iMLBuEfvLjhOyFWOG90Wdo1Ny+5naAF6UeQAZBz1VI3byYjY5egxlpwIKGGiw
	 kEm6/s4hvR4nOWDvqXrXrcdF8hOih0mA9ZuMIy1GnOIiS1dmH8CZDD2UxV1MQ3UTew
	 h0SS2/bTIX4aTOL7KFJDH2Ossacguqb8fsG22FuAidJ1ZwtahyxHDQVOCy8TcmEAdo
	 S9R3MlSxehpw/zKIPFpudVL7B/IwUdvPneUO8P/h5NpzWuLS64k3OryDQoZYNIUqGE
	 4xpg3pDPKHxHvlnxv4qWDtOMEKQWqy60y48zWGUhB6yJ7YAa3wT7ocEDoYSpeUAz4S
	 yCX4u4BGzwmag==
Received: from [192.168.88.10] (250.68.pool1.tetanet.cz [109.202.68.250])
	by smtpd-relay-7554644787-rh7xp (szn-email-smtpd/2.0.18) with ESMTPA
	id 097ed0fa-2add-41db-a992-6118e9e5d0ff;
	Thu, 14 Mar 2024 17:23:58 +0100
From: "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
To: linux-pm@vger.kernel.org
Date: Thu, 14 Mar 2024 17:23:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-710
Subject: turbostat does not indicate throttling on a Raptor Lake CPU
Message-ID: <65F3249B.4589.8163D04@Frantisek.Rysanek.post.cz>
Priority: normal
X-mailer: Pegasus Mail for Windows (4.81.1154)


--Message-Boundary-710
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

Dear Linux devs and fellow users,

first of all thanks for the great job that you're doing.
Specifically, I'd like to thank Len Brown for coding the turbostat 
utility (I hope I understand correctly that he is the principal 
author). Also I'd like to confess that I'm a fan of Intel, and that I 
prefer the lowest-end models in terms of power consumption. 
Therefore, the topic of this message is a bit of a foreign territory 
to me :-)

I like using Linux to test PC hardware, and every once in a while I 
have an opportunity to inspect an actual culprit. And, this is 
approx. my second occasion where thermals and throttling are in the 
game (and I have a bit of a clue of what I'm doing.)

On a previous occasion, I've done my homework (study) about what the 
various P-states, C-states and C-states are about. That was roughly 
about Haswell to Skylake time. This is when I sketched this picture:
http://support.fccps.cz/industry/pwr/cube.png
(My earlier poking at the EIST MSR's doesn't seem very relevant 
today.)

Yes I was trying to troubleshoot a piece of Haswell hardware, and 
that's where I became aware of the turbostat, among other software in 
this vein. And, since then I remember one particular MSR that has 
proven quite helpful to me:
MSR_CORE_PERF_LIMIT_REASONS

I know that after Haswell and Skylake, power management R&D at Intel 
went on :-) The steering of the P-states has moved from OS control to 
HW control, and has become further fine-grained, and whatnot.
I lost track.

Now I happen to have a machine in our workshop, based on the Intel 
i7-13700K. Yes, a K-model, the unlocked beast, of the relatively 
recent Raptor Lake generation. I've been past my age of the GHz race 
for decades now :-) My interest in the setup is more professional / 
academic. I'd like to update / fine-tune my tools and knowledge, for 
analyzing the borderline thermal states that this machine seems to be 
demonstrating. (You know - the machines that normally pass through my 
hands preferably never reach 50*C on the die.)
Shoud some PC setup pass through my hands, where the thermals are 
genuinely awry and not intentionally so, I'd need to see what's going 
on, I'd like to have the tools ready (as much as possible and fair to 
ask).

So... I PXE-booted my Debian-based diskless testbed, ran some 
multithreaded CPU benchmark to stress the CPU, waited for the fans to 
spin up, and kept watching from inside using turbostat, to see where 
some warnings about overheating start popping up. The machine has a 
pretty decent CPU heatsink, which however still lacks a bit of 
cooling power, compared to the immodest CPU TDP. And indeed, after a 
couple of minutes the CPU started hitting the TJmax expected at 
100*C. For the purposes of this test, this is intended.
(I don't tease the CPU and VRM for very long.)

Curiously to me, I don't see any grave warnings in the turbostat.
I can see the temperatures just lick 100*C from below, I can see the 
frequencies (P-state) backing off a little, but... no signs of the 
wretched T-state.
In particular, turbostat doesn't seem to be reporting the 
MSR_CORE_PERF_LIMIT_REASONS
to me.
I was wondering why that is. Has this MSR fallen out of favour, with 
the more recent CPU generations? Does it even still exist?

Turns out, that yes it does exist.
I could reach it using the "msr-tools", but in fact turbostat itself 
can be asked to follow a particular "custom" MSR for me. Such as:

turbostat --add msr0x64F,u32,raw,package,LMT_RSN

I'll try to attach a 9kB turbostat.log to this message (not sure if 
the mailing list accepts that). The point is, that the MSR seems to 
return a value of 0x10020002 , which can be interpreted as:
- since the last reset, there have been some instances of overheat 
and "curbing the turbo frequencies"
- I am "limiting performance" for temperature reasons right now!

Does that trailing "2" (bit 1 = ON) indicate a T-state active?

Originally I used the Turbostat present in Debian 11, which is 
v20.09.30. Later today I downloaded the latest release of Turbostat 
and compiled it from source code. That's 2023.11.07.
My questions and the attached dump/log file are based on this latest 
version.

Does the output of the latest Turbostat give any other hint that 
throttling is on?

Are there any other MSR's I could take a look at?

I have noticed that HWinfo in Windows does report throttling, and 
reports it "per CPU" (Turbostat parlance) = per thread (as per Intel 
Architecture Software Developer's Manual). How do I get my hands on 
that indication from Linux :-)

Any clues are welcome.
Thanks for your polite attention.

Frank


--Message-Boundary-710
Content-type: text/plain; charset=US-ASCII
Content-disposition: inline
Content-description: Attachment information.

The following section of this message contains a file attachment
prepared for transmission using the Internet MIME message format.
If you are using Pegasus Mail, or any other MIME-compliant system,
you should be able to save it or view it from within your mailer.
If you cannot, please ask your system administrator for assistance.

   ---- File information -----------
     File:  turbostat.log
     Date:  14 Mar 2024, 13:20
     Size:  8857 bytes.
     Type:  Unknown

--Message-Boundary-710
Content-type: Application/Octet-stream; name="turbostat.log"; type=Unknown
Content-disposition: attachment; filename="turbostat.log"
Content-transfer-encoding: BASE64

I3R1cmJvc3RhdCAtLWFkZCBtc3IweDY0Rix1MzIscmF3LHBhY2thZ2UsTE1UX1JTTgoKdHVy
Ym9zdGF0IHZlcnNpb24gMjAyMy4xMS4wNyAtIExlbiBCcm93biA8bGVuYkBrZXJuZWwub3Jn
PgpLZXJuZWwgY29tbWFuZCBsaW5lOiBkZWIxMWFtZDY0Lmtlcm5lbCBpbml0cmQ9ZGViMTFh
bWQ2NC5pbml0cmQgbmZzcm9vdD0xOTIuMTY4LjIuNDovdmFyL05GU2Jvb3QvZGViMTFfeDg2
XzY0IEJPT1RJRj0wMS03NC01Ni0zYy1lNS03NS1hMCBpcD1kaGNwIHJ3IHN5c3RlbWQudW5p
dD1ncmFwaGljYWwudGFyZ2V0IG5ldC5pZm5hbWVzPTAgaW50ZWxfaWRsZS5tYXhfY3N0YXRl
PTEgbWl0aWdhdGlvbnM9b2ZmCkNQVUlEKDApOiBHZW51aW5lSW50ZWwgMHgyMCBDUFVJRCBs
ZXZlbHMKQ1BVSUQoMSk6IGZhbWlseTptb2RlbDpzdGVwcGluZyAweDY6Yjc6MSAoNjoxODM6
MSkgbWljcm9jb2RlIDB4MTFkCkNQVUlEKDB4ODAwMDAwMDApOiBtYXhfZXh0ZW5kZWRfbGV2
ZWxzOiAweDgwMDAwMDA4CkNQVUlEKDEpOiBTU0UzIE1PTklUT1IgU01YIEVJU1QgVE0yIFRT
QyBNU1IgQUNQSS1UTSBIVCBUTQpDUFVJRCg2KTogQVBFUkYsIFRVUkJPLCBEVFMsIFBUTSwg
SFdQLCBIV1Bub3RpZnksIEhXUHdpbmRvdywgSFdQZXBwLCBIV1Bwa2csIE5vLUVQQgpjcHUw
OiBNU1JfSUEzMl9NSVNDX0VOQUJMRTogMHgwMDg1MDA4OSAoVENDIEVJU1QgTVdBSVQgUFJF
RkVUQ0ggVFVSQk8pCkNQVUlEKDcpOiBOby1TR1ggSHlicmlkCkNQVUlEKDB4MTUpOiBlYXhf
Y3J5c3RhbDogMiBlYnhfdHNjOiAxNzggZWN4X2NyeXN0YWxfaHo6IDM4NDAwMDAwClRTQzog
MzQxNyBNSHogKDM4NDAwMDAwIEh6ICogMTc4IC8gMiAvIDEwMDAwMDApCkNQVUlEKDB4MTYp
OiBiYXNlX21oejogMzQwMCBtYXhfbWh6OiA0MjAwIGJ1c19taHo6IDEwMApjcHUwOiBNU1Jf
UExBVEZPUk1fSU5GTzogMHg4MDgwODM4ZjE4MTIyMDAKOCAqIDEwMC4wID0gODAwLjAgTUh6
IG1heCBlZmZpY2llbmN5IGZyZXF1ZW5jeQozNCAqIDEwMC4wID0gMzQwMC4wIE1IeiBiYXNl
IGZyZXF1ZW5jeQpjcHUwOiBNU1JfVFVSQk9fUkFUSU9fTElNSVQ6IDB4MzUzNTM1MzUzNTM1
MzYzNgo1MyAqIDEwMC4wID0gNTMwMC4wIE1IeiBtYXggdHVyYm8gOCBhY3RpdmUgY29yZXMK
NTMgKiAxMDAuMCA9IDUzMDAuMCBNSHogbWF4IHR1cmJvIDcgYWN0aXZlIGNvcmVzCjUzICog
MTAwLjAgPSA1MzAwLjAgTUh6IG1heCB0dXJibyA2IGFjdGl2ZSBjb3Jlcwo1MyAqIDEwMC4w
ID0gNTMwMC4wIE1IeiBtYXggdHVyYm8gNSBhY3RpdmUgY29yZXMKNTMgKiAxMDAuMCA9IDUz
MDAuMCBNSHogbWF4IHR1cmJvIDQgYWN0aXZlIGNvcmVzCjUzICogMTAwLjAgPSA1MzAwLjAg
TUh6IG1heCB0dXJibyAzIGFjdGl2ZSBjb3Jlcwo1NCAqIDEwMC4wID0gNTQwMC4wIE1IeiBt
YXggdHVyYm8gMiBhY3RpdmUgY29yZXMKNTQgKiAxMDAuMCA9IDU0MDAuMCBNSHogbWF4IHR1
cmJvIDEgYWN0aXZlIGNvcmVzCmNwdTA6IE1TUl9TRUNPTkRBUllfVFVSQk9fUkFUSU9fTElN
SVQ6IDB4MmEyYTJhMmEyYTJhMmEyYQo0MiAqIDEwMC4wID0gNDIwMC4wIE1IeiBtYXggdHVy
Ym8gOCBhY3RpdmUgY29yZXMKNDIgKiAxMDAuMCA9IDQyMDAuMCBNSHogbWF4IHR1cmJvIDcg
YWN0aXZlIGNvcmVzCjQyICogMTAwLjAgPSA0MjAwLjAgTUh6IG1heCB0dXJibyA2IGFjdGl2
ZSBjb3Jlcwo0MiAqIDEwMC4wID0gNDIwMC4wIE1IeiBtYXggdHVyYm8gNSBhY3RpdmUgY29y
ZXMKNDIgKiAxMDAuMCA9IDQyMDAuMCBNSHogbWF4IHR1cmJvIDQgYWN0aXZlIGNvcmVzCjQy
ICogMTAwLjAgPSA0MjAwLjAgTUh6IG1heCB0dXJibyAzIGFjdGl2ZSBjb3Jlcwo0MiAqIDEw
MC4wID0gNDIwMC4wIE1IeiBtYXggdHVyYm8gMiBhY3RpdmUgY29yZXMKNDIgKiAxMDAuMCA9
IDQyMDAuMCBNSHogbWF4IHR1cmJvIDEgYWN0aXZlIGNvcmVzCmNwdTA6IE1TUl9DT05GSUdf
VERQX05PTUlOQUw6IDB4MDAwMDAwMjIgKGJhc2VfcmF0aW89MzQpCmNwdTA6IE1TUl9DT05G
SUdfVERQX0xFVkVMXzE6IDB4MDAwMDAwMDAgKCkKY3B1MDogTVNSX0NPTkZJR19URFBfTEVW
RUxfMjogMHgwMDAwMDAwMCAoKQpjcHUwOiBNU1JfQ09ORklHX1REUF9DT05UUk9MOiAweDgw
MDAwMDAwICggbG9jaz0xKQpjcHUwOiBNU1JfVFVSQk9fQUNUSVZBVElPTl9SQVRJTzogMHgw
MDAwMDAwMCAoTUFYX05PTl9UVVJCT19SQVRJTz0wIGxvY2s9MCkKY3B1MDogY3B1ZnJlcSBk
cml2ZXI6IGludGVsX3BzdGF0ZQpjcHUwOiBjcHVmcmVxIGdvdmVybm9yOiBwb3dlcnNhdmUK
Y3B1ZnJlcSBpbnRlbF9wc3RhdGUgbm9fdHVyYm86IDAKY3B1MDogTVNSX01JU0NfUFdSX01H
TVQ6IDB4MDAwMDMwYzIgKEVOYWJsZS1FSVNUX0Nvb3JkaW5hdGlvbiBFTmFibGUtRVBCIERJ
U2FibGUtT09CKQpjcHUwOiBNU1JfUE1fRU5BQkxFOiAweDAwMDAwMDAxIChIV1ApCmNwdTA6
IE1TUl9IV1BfQ0FQQUJJTElUSUVTOiAweDAxMTYyYzQ0IChoaWdoIDY4IGd1YXIgNDQgZWZm
IDIyIGxvdyAxKQpjcHUwOiBNU1JfSFdQX1JFUVVFU1Q6IDB4ODAwMDQ0MDggKG1pbiA4IG1h
eCA2OCBkZXMgMCBlcHAgMHg4MCB3aW5kb3cgMHgwIHBrZyAweDApCmNwdTA6IE1TUl9IV1Bf
UkVRVUVTVF9QS0c6IDB4ODAwMGZmMDEgKG1pbiAxIG1heCAyNTUgZGVzIDAgZXBwIDB4ODAg
d2luZG93IDB4MCkKY3B1MDogTVNSX0hXUF9JTlRFUlJVUFQ6IDB4MDAwMDAwMDAgKERpc19H
dWFyYW50ZWVkX1BlcmZfQ2hhbmdlLCBEaXNfRXhjdXJzaW9uX01pbikKY3B1MDogTVNSX0hX
UF9TVEFUVVM6IDB4MDAwMDAwMDAgKE5vLUd1YXJhbnRlZWRfUGVyZl9DaGFuZ2UsIE5vLUV4
Y3Vyc2lvbl9NaW4pCmNwdTA6IE1TUl9JQTMyX1BPV0VSX0NUTDogMHgwMGY4MDA1ZiAoQzFF
IGF1dG8tcHJvbW90aW9uOiBFTmFibGVkKQpjcHUwOiBNU1JfUEtHX0NTVF9DT05GSUdfQ09O
VFJPTDogMHg3NDAwMDAwMCAoVU5kZW1vdGUtQzEsIGRlbW90ZS1DMSwgVU5sb2NrZWQsIHBr
Zy1jc3RhdGUtbGltaXQ9MCAocGMwKSkKL2Rldi9jcHVfZG1hX2xhdGVuY3k6IDIwMDAwMDAw
MDAgdXNlYyAoZGVmYXVsdCkKY3VycmVudF9kcml2ZXI6IGludGVsX2lkbGUKY3VycmVudF9n
b3Zlcm5vcjogbWVudQpjdXJyZW50X2dvdmVybm9yX3JvOiBtZW51CmNwdTA6IFBPTEw6IENQ
VUlETEUgQ09SRSBQT0xMIElETEUKY3B1MDogQzFBQ1BJOiBBQ1BJIEZGSCBNV0FJVCAweDAK
Y3B1MDogTVNSX1BLR0MzX0lSVEw6IDB4MDAwMDAwMDAgKE5PVHZhbGlkLCAwIG5zKQpjcHUw
OiBNU1JfUEtHQzZfSVJUTDogMHgwMDAwMDAwMCAoTk9UdmFsaWQsIDAgbnMpCmNwdTA6IE1T
Ul9QS0dDOF9JUlRMOiAweDAwMDAwMDAwIChOT1R2YWxpZCwgMCBucykKY3B1MDogTVNSX1BL
R0MxMF9JUlRMOiAweDAwMDAwMDAwIChOT1R2YWxpZCwgMCBucykKUkFQTDogMjA5NyBzZWMu
IEpvdWxlIENvdW50ZXIgUmFuZ2UsIGF0IDEyNSBXYXR0cwpjcHUwOiBNU1JfUkFQTF9QT1dF
Ul9VTklUOiAweDAwMGEwZTAzICgwLjEyNTAwMCBXYXR0cywgMC4wMDAwNjEgSm91bGVzLCAw
LjAwMDk3NyBzZWMuKQpjcHUwOiBNU1JfUEtHX1BPV0VSX0lORk86IDB4MDAwMDAzZTggKDEy
NSBXIFREUCwgUkFQTCAwIC0gMCBXLCAwLjAwMDAwMCBzZWMuKQpjcHUwOiBNU1JfUEtHX1BP
V0VSX0xJTUlUOiAweDQzZmZmODAwMWJmZmY4IChVTmxvY2tlZCkKY3B1MDogUEtHIExpbWl0
ICMxOiBFTmFibGVkICg0MDk1LjAwMCBXYXR0cywgOC4wMDAwMDAgc2VjLCBjbGFtcCBFTmFi
bGVkKQpjcHUwOiBQS0cgTGltaXQgIzI6IEVOYWJsZWQgKDQwOTUuMDAwIFdhdHRzLCAwLjAw
MjQ0MSogc2VjLCBjbGFtcCBFTmFibGVkKQpjcHUwOiBNU1JfVlJfQ1VSUkVOVF9DT05GSUc6
IDB4MDAwMDAwMDAKY3B1MDogUEtHIExpbWl0ICM0OiAwLjAwMDAwMCBXYXR0cyAoVU5sb2Nr
ZWQpCmNwdTA6IE1TUl9EUkFNX1BPV0VSX0xJTUlUOiAweDE0ZmZmODAwMTRmZmY4IChVTmxv
Y2tlZCkKY3B1MDogRFJBTSBMaW1pdDogRU5hYmxlZCAoNDA5NS4wMDAgV2F0dHMsIDEuMDAw
MDAwIHNlYywgY2xhbXAgRElTYWJsZWQpCmNwdTA6IE1TUl9QUDBfUE9MSUNZOiAwCmNwdTA6
IE1TUl9QUDBfUE9XRVJfTElNSVQ6IDB4MDAwMDAwMDAgKFVObG9ja2VkKQpjcHUwOiBDb3Jl
cyBMaW1pdDogRElTYWJsZWQgKDAuMDAwIFdhdHRzLCAwLjAwMDk3NyBzZWMsIGNsYW1wIERJ
U2FibGVkKQpjcHUwOiBNU1JfUFAxX1BPTElDWTogMApjcHUwOiBNU1JfUFAxX1BPV0VSX0xJ
TUlUOiAweDAwMDAwMDAwIChVTmxvY2tlZCkKY3B1MDogR0ZYIExpbWl0OiBESVNhYmxlZCAo
MC4wMDAgV2F0dHMsIDAuMDAwOTc3IHNlYywgY2xhbXAgRElTYWJsZWQpCmNwdTA6IE1TUl9J
QTMyX1RFTVBFUkFUVVJFX1RBUkdFVDogMHg4MDY0MTQwMCAoMTAwIEMpICgxMDAgZGVmYXVs
dCAtIDAgb2Zmc2V0KQpjcHUwOiBNU1JfSUEzMl9QQUNLQUdFX1RIRVJNX1NUQVRVUzogMHg4
ODAwMDNjMyAoMTAwIEMpCmNwdTA6IE1TUl9JQTMyX1BBQ0tBR0VfVEhFUk1fSU5URVJSVVBU
OiAweDAwMDAwMDAzICgxMDAgQywgMTAwIEMpCmNwdTA6IE1TUl9NSVNDX0ZFQVRVUkVfQ09O
VFJPTDogMHgwMDAwMDAwMCAoTDItUHJlZmV0Y2ggTDItUHJlZmV0Y2gtcGFpciBMMS1QcmVm
ZXRjaCBMMS1JUC1QcmVmZXRjaCkKQ29yZQlDUFUJQXZnX01IeglCdXN5JQlCenlfTUh6CVRT
Q19NSHoJSVBDCUlSUQlTTUkJUE9MTAlDMUFDUEkJUE9MTCUJQzFBQ1BJJQlDUFUlYzEJQ1BV
JWM2CUNQVSVjNwlDb3JlVG1wCUNvcmVUaHIJUGtnVG1wCVRvdGwlQzAJQW55JUMwCUdGWCVD
MAlDUFVHRlglCVBrZ1dhdHQJQ29yV2F0dAlHRlhXYXR0CVJBTVdhdHQJUEtHXyUJUkFNXyUJ
ICAgTE1UX1JTTgotCS0JNDIyMQkxMDAuMDEJNDIyMAkzNDE4CTEuODkJMjM3NDc0CTAJNzEz
OAkyMTcJMC4wMwkwLjAwCTAuMDAJMC4wMAkwLjAwCTEwMAkyNTk3MTIJMTAwCTE2MDguMzAJ
MTAwLjUyCTAuMDAJMC4wMAkxODMuMDEJMTgxLjQ1CTAuMDAJMC4wMAkwLjAwCTAuMDAJMHgw
MDAwMDAwMAowCTAJNDU1MQkxMDAuMDIJNDU1MAkzNDE4CTEuOTkJMTE0OTcJMAkwCTAJMC4w
MAkwLjAwCTAuMDAJMC4wMAkwLjAwCTg5CTAJMTAwCTE2MDguMjkJMTAwLjUyCTAuMDAJMC4w
MAkxODMuMDAJMTgxLjQ0CTAuMDAJMC4wMAkwLjAwCTAuMDAJMHgxMDAyMDAwMgowCTEJNDU1
MQkxMDAuMDIJNDU1MAkzNDE4CTIuMDgJMTI5NjEJMAkwCTAJMC4wMAkwLjAwCTAuMDAKNAky
CTQ1NTEJMTAwLjAyCTQ1NTAJMzQxOAkyLjA2CTYxOTYJMAkwCTAJMC4wMAkwLjAwCTAuMDAJ
MC4wMAkwLjAwCTk1CTY0OTUKNAkzCTQ1NTEJMTAwLjAyCTQ1NTAJMzQxOAkyLjA5CTY1MjUJ
MAkwCTAJMC4wMAkwLjAwCTAuMDAKOAk0CTQ1NTEJMTAwLjAyCTQ1NTAJMzQxOAkyLjA3CTM4
NzkJMAkwCTAJMC4wMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTk2CTE5Mzg4CjgJNQk0NTUxCTEw
MC4wMgk0NTUwCTM0MTgJMi4wOAkzOTMwCTAJMAkwCTAuMDAJMC4wMAkwLjAwCjEyCTYJNDU1
MQkxMDAuMDIJNDU1MAkzNDE4CTEuOTUJMTg5MTMJMAkwCTAJMC4wMAkwLjAwCTAuMDAJMC4w
MAkwLjAwCTk3CTI4MTE4CjEyCTcJNDU1MQkxMDAuMDIJNDU1MAkzNDE4CTIuMDgJMjQzMzEJ
MAkwCTAJMC4wMAkwLjAwCTAuMDAKMTYJOAk0NTUxCTEwMC4wMgk0NTUxCTM0MTgJMi4wNgk0
Mjg2CTAJMAkwCTAuMDAJMC4wMAkwLjAwCTAuMDAJMC4wMAk5NQkxNTI5MAoxNgk5CTQ1NTEJ
MTAwLjAyCTQ1NTEJMzQxOAkyLjA3CTQ1NjEJMAkwCTAJMC4wMAkwLjAwCTAuMDAKMjAJMTAJ
NDU1MQkxMDAuMDIJNDU1MQkzNDE4CTIuMDIJMTA3NzQJMAkwCTAJMC4wMAkwLjAwCTAuMDAJ
MC4wMAkwLjAwCTEwMAkyNTk3MTIKMjAJMTEJNDU1MQkxMDAuMDIJNDU1MQkzNDE4CTIuMDkJ
MTE2MDQJMAkwCTAJMC4wMAkwLjAwCTAuMDAKMjQJMTIJNDU0OQkxMDAuMDIJNDU0OAkzNDE4
CTEuOTcJMjk5NgkwCTAJMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTAuMDAJOTYJMTEzNzgKMjQJ
MTMJNDU0OQkxMDAuMDIJNDU0OAkzNDE4CTIuMjkJMjk0MQkwCTAJMAkwLjAwCTAuMDAJMC4w
MAoyOAkxNAk0NTQ3CTk5LjkzCTQ1NTAJMzQxOAkxLjg2CTE2NDUwCTAJNzEzOAkyMTcJMC42
NgkwLjA5CTAuMDAJMC4wMAkwLjAwCTk2CTE3MTcKMjgJMTUJNDU1MQkxMDAuMDIJNDU1MAkz
NDE4CTIuMDkJMjczMTEJMAkwCTAJMC4wMAkwLjAwCTAuMDAKMzIJMTYJMzU2MAkxMDAuMDIJ
MzU1OQkzNDE4CTEuNTEJNTU4OAkwCTAJMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTAuMDAJOTAJ
MAozMwkxNwkzNTYwCTEwMC4wMgkzNTU5CTM0MTgJMS40NgkxMDY1MwkwCTAJMAkwLjAwCTAu
MDAJMC4wMAkwLjAwCTAuMDAJOTAJMAozNAkxOAkzNTYwCTEwMC4wMgkzNTU5CTM0MTgJMS40
NAkxMjM4OAkwCTAJMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTAuMDAJOTAJMAozNQkxOQkzNTYw
CTEwMC4wMgkzNTU5CTM0MTgJMS41MwkyNzk3CTAJMAkwCTAuMDAJMC4wMAkwLjAwCTAuMDAJ
MC4wMAk5MAkwCjM2CTIwCTM1NjIJMTAwLjAyCTM1NjIJMzQxOAkxLjQ1CTEwMzEwCTAJMAkw
CTAuMDAJMC4wMAkwLjAwCTAuMDAJMC4wMAk5MQkwCjM3CTIxCTM1NjIJMTAwLjAyCTM1NjIJ
MzQxOAkxLjQ5CTU3MTgJMAkwCTAJMC4wMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTkxCTAKMzgJ
MjIJMzU2MgkxMDAuMDIJMzU2MgkzNDE4CTEuMzcJMTc3ODAJMAkwCTAJMC4wMAkwLjAwCTAu
MDAJMC4wMAkwLjAwCTkxCTAKMzkJMjMJMzU2MgkxMDAuMDIJMzU2MgkzNDE4CTEuNTEJMzA4
NQkwCTAJMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTAuMDAJOTEJMApDb3JlCUNQVQlBdmdfTUh6
CUJ1c3klCUJ6eV9NSHoJVFNDX01IeglJUEMJSVJRCVNNSQlQT0xMCUMxQUNQSQlQT0xMJQlD
MUFDUEklCUNQVSVjMQlDUFUlYzYJQ1BVJWM3CUNvcmVUbXAJQ29yZVRocglQa2dUbXAJVG90
bCVDMAlBbnklQzAJR0ZYJUMwCUNQVUdGWCUJUGtnV2F0dAlDb3JXYXR0CUdGWFdhdHQJUkFN
V2F0dAlQS0dfJQlSQU1fJQkgICBMTVRfUlNOCi0JLQk0MTk2CTEwMC4wMQk0MTk5CTM0MTQJ
MS44OQkyMzc0ODgJMAkyNzAwNQk1NzYJMC4xMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTEwMAky
NjA0NTYJMTAwCTE2MDguMTMJMTAwLjUxCTAuMDAJMC4wMAkxODAuNDYJMTc4LjkwCTAuMDAJ
MC4wMAkwLjAwCTAuMDAJMHgwMDAwMDAwMAowCTAJNDUyNgkxMDAuMDIJNDUyNQkzNDE4CTIu
MDgJMjc1OAkwCTAJMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTAuMDAJODkJMAkxMDAJMTYwOC4y
OAkxMDAuNTIJMC4wMAkwLjAwCTE4MC42NAkxNzkuMDgJMC4wMAkwLjAwCTAuMDAJMC4wMAkw
eDEwMDIwMDAyCjAJMQk0NTI2CTEwMC4wMgk0NTI1CTM0MTgJMi4wOAkyNzY1CTAJMAkwCTAu
MDAJMC4wMAkwLjAwCjQJMgk0NTI2CTEwMC4wMgk0NTI1CTM0MTgJMi4wNwk1MDYyCTAJMAkw
CTAuMDAJMC4wMAkwLjAwCTAuMDAJMC4wMAk5NQk2NDk3CjQJMwk0NTI2CTEwMC4wMgk0NTI1
CTM0MTgJMi4xMAk1MzMzCTAJMAkwCTAuMDAJMC4wMAkwLjAwCjgJNAk0NTI0CTEwMC4wMAk0
NTI0CTM0MTgJMS42MgkyNTI1OAkwCTIxNjE5CTQ2MAkyLjAxCTAuMDIJMC4wMAkwLjAwCTAu
MDAJOTIJMTkzODkKOAk1CTQ1MjUJMTAwLjAyCTQ1MjQJMzQxOAkyLjA4CTUyNTg5CTAJMAkw
CTAuMDAJMC4wMAkwLjAwCjEyCTYJNDUyNQkxMDAuMDIJNDUyNQkzNDE4CTIuMDgJNDQyNAkw
CTAJMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTAuMDAJOTcJMjgxMjEKMTIJNwk0NTI1CTEwMC4w
Mgk0NTI1CTM0MTgJMi4wOQk1Njk1CTAJMAkwCTAuMDAJMC4wMAkwLjAwCjE2CTgJNDUyMgk5
OS45NAk0NTI0CTM0MTgJMS43OQkyNjMwMgkwCTUzODYJMTE2CTAuNDkJMC4wOAkwLjAwCTAu
MDAJMC4wMAk5NQkxNTI5MwoxNgk5CTQ1MjUJMTAwLjAyCTQ1MjQJMzQxOAkyLjA3CTM2MDEz
CTAJMAkwCTAuMDAJMC4wMAkwLjAwCjIwCTEwCTQ1MjYJMTAwLjAyCTQ1MjUJMzQxOAkyLjA5
CTM0NDYJMAkwCTAJMC4wMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTEwMAkyNjA0NTYKMjAJMTEJ
NDUyNgkxMDAuMDIJNDUyNQkzNDE4CTIuMTAJMzUxMwkwCTAJMAkwLjAwCTAuMDAJMC4wMAoy
NAkxMgk0NTI1CTEwMC4wMgk0NTI0CTM0MTgJMi4wMwkyODM4CTAJMAkwCTAuMDAJMC4wMAkw
LjAwCTAuMDAJMC4wMAk5NwkxMTM4MgoyNAkxMwk0NTI1CTEwMC4wMgk0NTI0CTM0MTgJMi4x
OQkyNzUxCTAJMAkwCTAuMDAJMC4wMAkwLjAwCjI4CTE0CTQ1MjYJMTAwLjAyCTQ1MjUJMzQx
OAkyLjA5CTI3NjQJMAkwCTAJMC4wMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTk1CTE3MTkKMjgJ
MTUJNDUyNgkxMDAuMDIJNDUyNQkzNDE4CTIuMDkJMjg0NwkwCTAJMAkwLjAwCTAuMDAJMC4w
MAozMgkxNgkzNTQ2CTEwMC4wMgkzNTQ1CTM0MTgJMS41MwkyNzU4CTAJMAkwCTAuMDAJMC4w
MAkwLjAwCTAuMDAJMC4wMAk5MAkwCjMzCTE3CTM1NDYJMTAwLjAyCTM1NDUJMzQxOAkxLjQ3
CTk3MTAJMAkwCTAJMC4wMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTkwCTAKMzQJMTgJMzU0Ngkx
MDAuMDIJMzU0NQkzNDE4CTEuNDgJODAxMgkwCTAJMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTAu
MDAJOTAJMAozNQkxOQkzNTQ2CTEwMC4wMgkzNTQ1CTM0MTgJMS41MAk1NjE0CTAJMAkwCTAu
MDAJMC4wMAkwLjAwCTAuMDAJMC4wMAk5MAkwCjM2CTIwCTM1NTEJMTAwLjAyCTM1NTEJMzQx
OAkxLjUwCTY0ODQJMAkwCTAJMC4wMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTkxCTAKMzcJMjEJ
MzU1MQkxMDAuMDIJMzU1MQkzNDE4CTEuNTMJMzI3MAkwCTAJMAkwLjAwCTAuMDAJMC4wMAkw
LjAwCTAuMDAJOTEJMAozOAkyMgkzNTUxCTEwMC4wMgkzNTUxCTM0MTgJMS40OQkxMDE2Nwkw
CTAJMAkwLjAwCTAuMDAJMC4wMAkwLjAwCTAuMDAJOTEJMAozOQkyMwkzNTUxCTEwMC4wMgkz
NTUxCTM0MTgJMS40OQk3MTE1CTAJMAkwCTAuMDAJMC4wMAkwLjAwCTAuMDAJMC4wMAk5MQkw
Cg==

--Message-Boundary-710--

