Return-Path: <linux-pm+bounces-42045-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KPoEecNg2k+hAMAu9opvQ
	(envelope-from <linux-pm+bounces-42045-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 10:14:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D17E3A0E
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 10:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E273006396
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BD43A1A4A;
	Wed,  4 Feb 2026 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="c2TKLV/R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724538F229;
	Wed,  4 Feb 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196164; cv=none; b=dbDbAbr176mlBPobhVhF1avq47RX1hRRRKjMWfAM5+SFLcFzHCrseh9/uJ5INQnakBn/9BJDl6nLYhFY5eCwqPQbE+kellN9vbFKzPBHLOYbKPxNphLemvRjWQlqVBkVGhw8ylqK7BhuecTqsLLeDxKSpbGEZxFZEHXOX4+7gvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196164; c=relaxed/simple;
	bh=YqeC36Zi65EbOpXzZTcvvalno75V9xuV8r6nVCSvqWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLJKySXGccVsB2s6NSfpYqlIETM6opp5S5HorkpM2Obczn8/BLQkAx9bBrfh3+DmufbiKQTfgTRHdTbBbTHcxWssSjn9cHsmXtd62LFCjrRuDc24CcLrZxmQMhvETDyiMTF0uOB590IFrelf8huFJSQism7+B29OUob0xa5KBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=c2TKLV/R; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1770196149; x=1770800949; i=laurent@vivier.eu;
	bh=TWBInZV3kqanjFBrYN5cczADjeH7FJFi7Tgb+2byjEo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c2TKLV/RfEgB8qXTGu6c/jipkxjsh7q7T8L8OAY0UqhvYoqUQ2JdPNEyrIVKjNUV
	 ybzhLFeLl9Io7yN4vajwgdL/rxITx3dYmqAS7AC6uvL0Xlo5ACNRB3xz/exJm3Hv0
	 Oxi8XWLa5xPmxVagMu1PRDpRp5aFoTUkSbMQqaHsCl7UZVPn+Ty57b6opkKIRRaZ7
	 M4swMs1irMyEX3NscfXCfiLNHVs0dr8VWoRhjZJs/KzX1oA9RSqR21y03ZmRp+7SU
	 et5rZqTmeVTd45MWGRAeQQZvRfyGdWU/od2wEZBGfsGgBLX4WDJPDoa+791YdVetM
	 xNdMWt+QJ3Xz0UEqTw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MfI21-1vKHs603y7-00b9nl; Wed, 04 Feb 2026 10:09:09 +0100
Message-ID: <e7ddd671-6e25-4114-9d4c-21ecebe82ef5@vivier.eu>
Date: Wed, 4 Feb 2026 10:09:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add QEMU virt-ctrl driver and update m68k virt
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: sre@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 daniel@0x0f.com, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20260203170824.2968045-1-visitorckw@gmail.com>
 <CAMuHMdUMBoLd8cKXMK64qjGfTqQfK21mDAXMh8DdJHkL7QbDVQ@mail.gmail.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <CAMuHMdUMBoLd8cKXMK64qjGfTqQfK21mDAXMh8DdJHkL7QbDVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tJ1BeFvxZpsrOTN5twRnOAvQ3YpOc/nyUOzNfaEl1fe4EmDwlNG
 g63Z39D5Ci+BDmRyq16QCj/dhjvoCIYgt155K2KQCOMnSaxOXWysJTVfGCRXvsuGy9/XwYQ
 5lyJvUeJh9tqnTLOm4qQVL9Wk6pCILhNpx0N7RJGoUfs/SsgWKLMThU/AOKH6tcLv6S0AF9
 2EZIw7ssukYrV74ga5j8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:12sZz05K+OM=;ewJeMiwOBgQquELntq9D9S5k8Fb
 yAXNPkouxkRFaC8xvsa4ZexKKsOhmk4EdlXyNLhrUsv9bNR0UBawsTUH0ygiaObx5vq8V28WZ
 KwpX6qYvXB/UVApq76dgJkexNArl9Pv0w147jxoC0p2tf8V+8A6uAcv0jD0u6KtkIpCE+EqEH
 YN5pn9HOimClitS05cALsLu5ugDQPUCCUs9VjMsa1jpkJ4k3oc4Pita+bpJbD1dNDGOnLw0d/
 1x6788P/AVA4lvpk+HUEzaUj9rzlWiMvehpGHzSP3XtbIhBObInyOfc8cI4nJcCj10qoW93KV
 fqpmmxybOGFbynrXXnll9rtky3njknn6aB9+H61FtaimFh6pyNuxZrImk0hhKDLT9bw79NT5D
 hFvUClqNWWcudMPd/loe1K+gsA6uJHp/uo/eTnh3UEX55rKn0ORHP1wHuF99uMDHFSuxLbCon
 9FBNVUn7JKXAd2ZE+0hb3DEEulmn/mI5DvjjJCTn8nSsn5fhyES6eQyWxkOaenVHjR6EoEBG4
 jh68EUa3iFcAAlALyMVNW98IGvQb2v1g/rPM3ikK32OCGrZnaXGjs3+HHUWSke+fcRJjw9puY
 07fBXOnfx9FABf7kyivaUwenJ5gmqug6bqReVVVCHepQgaYI0Fp0R/5HZJH+VVa88D6II8why
 RuOEZ7/+ozTAq+rhBHRzvtgwpuVuAvEB32jjUNOpoJvRljfmC+zdEXDIsm4xixkkYcZ1HNcXT
 MZu6Tn91RpHJRvKdLZLaB+YGTJgdzpvpHK37ED9zXeyt+zrseUrLsellDUtTnGyVdiNy0qcec
 qHSXdlmeZRrqvWD3fDXYK475GSe3Hm/gMWOq+EvrHHTS4HWCa9pDaL/lmfD4B2tXA6JXyMn1V
 M9NEwv3eOns+Q6ZlnuAe+fZ4au/5YaT7t4ywqzXBrHTL/BvDePVuY+R+mjOOSDDFAdAqMLSU/
 bEFYYWoe3ZYKmXCbXtXZKD+EDPfBE+5O3FRgI92XEeiP6JekW50qWpfpHRHvxGXCoNXGQjMH5
 IsdvJ08nmD9PW97giamZ7gSmuPaKJU3yPhXNV/szdZzb923ifL+HuzgJf+kCdx7jaRHiEphiA
 4TaoHxzqQQsLcd/NMakTdPZCPi8EVkhCzCTClYTyut3oEq6/oTDtfX3pNrNc1Va3c+IfbnXh2
 jlOBq6z4ll+NBD+JB1ZiH9C/cX1qlx7PPR/saCJGLvMPD3Px8FWajhW5eunkw3l0CNDNMkR4t
 rSRtif5PFXBoNNTECEamdFw+too2oYVgSftHWJYs4OM8nCgJCkQYJ8XUIRYoWFsQXO/D7ZhTO
 CbikNP8Weuga2tUdAg+V5rCGADq+bJlQkp+Q8WSR4lwjGPTLd/b8J0bjLuiss7XsXawyWwdPe
 OqkvO/YKVxAKrCsao1a0kbkOORXUCBTG393K2J6Nmh65/C8HICvqvx4FQfcMZWvLCyX/1YYp7
 l1Wejh6rNvjLV/mJuc6Jf2nH4KBuVCvJh4n8LMAEse82pi2n5zxTGkrqPRKOqWaYDOInd3ezY
 EPBkF5WKrvCBELxtaqFg2nmGKNHhZX9ijKfMXkx/UIwkuqOQnQRqJRZViZWgk9uenigeXjBd/
 NiZ+oGtycUBuavQJibOuEyh9dltJeyPW8yxw8RxPIehyDqhkUT0OgyK15jDM/9N0ykt+5UAuZ
 OEdyFNC/FgOkKtOAgXeZtpZWoa8/axpi1hh5QOBQ7l46Sk+ZdeHcXWX1XDA0ADWUVOAmbqh0+
 KsTfJlZGmZuDi1DTv2lco6VgMogvq3Bj9/q+G0HIrqGKN3iOZRB0zGE8ppwOcteTUa02WiQwR
 Kn2y
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[vivier.eu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[vivier.eu:s=s1-ionos];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42045-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,ccns.ncku.edu.tw,gmail.com,0x0f.com,vger.kernel.org,lists.linux-m68k.org,linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[vivier.eu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent@vivier.eu,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivier.eu:mid,vivier.eu:dkim]
X-Rspamd-Queue-Id: 99D17E3A0E
X-Rspamd-Action: no action

Le 04/02/2026 =C3=A0 08:56, Geert Uytterhoeven a =C3=A9crit=C2=A0:
> CC vivier

Thank you Geert

> On Tue, 3 Feb 2026 at 18:08, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>> Introduce a generic platform driver for the QEMU 'virt-ctrl' device [1]
>> and transitions the m68k 'virt' machine to use it, replacing
>> architecture-specific hooks.
>>
>> The new driver ('qemu-virt-ctrl') registers a restart handler and
>> populates the global 'pm_power_off' callback.
>>
>> On the m68k side, the platform initialization is updated to register
>> the 'qemu-virt-ctrl' platform device. Additionally, the 'mach_reset'
>> hook is bridged to 'do_kernel_restart()' to ensure the kernel's restart
>> handler chain is correctly invoked.
>>
>> Verified on QEMU m68k virt. Both system reset and power-off were
>> confirmed functional by invoking 'reboot(LINUX_REBOOT_CMD_RESTART)' and
>> 'reboot(LINUX_REBOOT_CMD_POWER_OFF)' from userspace.
>>
>> Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_=
ctrl.c [1]
>> ---
>> Changes in v2:
>> - Use devm_register_sys_off_handler() instead of register_restart_handl=
er()
>>    and global pm_power_off.
>> - Switch Kconfig to tristate to support modular build.
>> - Add .id_table to platform_driver and use MODULE_DEVICE_TABLE() to cor=
rect
>>    module auto-loading.
>>
>> v1: https://lore.kernel.org/lkml/20260112182258.1851769-1-visitorckw@gm=
ail.com/
>>
>> Kuan-Wei Chiu (2):
>>    power: reset: Add QEMU virt-ctrl driver
>>    m68k: virt: Switch to qemu-virt-ctrl driver
>>
>>   MAINTAINERS                          |  6 ++
>>   arch/m68k/virt/config.c              | 42 +------------
>>   arch/m68k/virt/platform.c            | 20 ++++++-
>>   drivers/power/reset/Kconfig          | 10 ++++
>>   drivers/power/reset/Makefile         |  1 +
>>   drivers/power/reset/qemu-virt-ctrl.c | 89 +++++++++++++++++++++++++++=
+
>>   6 files changed, 124 insertions(+), 44 deletions(-)
>>   create mode 100644 drivers/power/reset/qemu-virt-ctrl.c
>>
>> --
>> 2.53.0.rc1.225.gd81095ad13-goog

Some comments on the series:
- Please test LINUX_REBOOT_CMD_HALT as well. With mach_halt removed,
   HALT now falls back to machine_halt()=E2=80=99s infinite loop (no CMD_H=
ALT),
   so behavior changes.
- Please add select POWER_RESET_QEMU_VIRT_CTRL under config VIRT
   in arch/m68k/Kconfig.machine to avoid a restart regression when the
   driver isn=E2=80=99t built-in.
- Endianness: QEMU=E2=80=99s virt-ctrl is DEVICE_NATIVE_ENDIAN, so BE on m=
68k but
   LE elsewhere. If the driver is meant to be generic, handle native endia=
nness
   instead of hardcoding iowrite32be().

FWIW, I originally modeled virt-ctrl as a generic misc device, but since i=
t only
exposes power/reset today, keeping the driver under drivers/power/reset is=
 fine...

Please cc: me on the next version

Thanks,
Laurent


