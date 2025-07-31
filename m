Return-Path: <linux-pm+bounces-31676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDDCB16E84
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 11:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7A05A7C21
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B329E0EE;
	Thu, 31 Jul 2025 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="eQcwnYy3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C84028E5F3;
	Thu, 31 Jul 2025 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953841; cv=none; b=YdiNlVf13uF7Wa4L4ty4+uLlHXqBsu0nRxTFy5KIW4vB/dJ/TbwBxhXMhRe4Ya9wjFJ5SAxLRSZJxeyzv/6DdotI/NExI8uV9gxJrr2h/oWgknM1niTbUDnBkh97xf4ddUGDf9PNAiJws4g1+V0rSmfenhzKyUIetYZmno4Rye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953841; c=relaxed/simple;
	bh=KHVqfClGcywSNPvumHIpUR02TTFKZhuUNnx66KgJbpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fs7Pcga8/lCZ7rnOpiH+ovP9vw4UtA+028Jr/SHNip5lGlFl7Cx3v2L3uWJfytpDW40T/HtJcsD+nQolEQxHXMejEtMCcmoCfR4CwftvO6OSGyWAe1S9Q6065Mbkn6IEKjoBw91KygGYv05433dAAGchL30vGgwZhvKYvXiq9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=eQcwnYy3; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753953800; x=1754558600; i=spasswolf@web.de;
	bh=ikaEml9w3dyXhHBQvEZKQ0cq7LHSb+7nWDGYVpVg19M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eQcwnYy3UL4ZZC0p+jAbAapCSkeH7+guXbFGU5QEO4743XV9u0bvYGce+W9eIHzZ
	 9jkNiRVinsm2MFCHB+vOoskqU+4I4bCvYs7ieLt9Q6QK3B0OifNrKZ5tZLPAvYM6w
	 H5IgwzMdBeFqJ0CPF6oV6EnG50aj3msUwt8UaaVJEzRvBRrj3oiTOmE0K9Gi76ve9
	 vZp98YCiRAykXksSOIQSKIoDJzrNAIaLk8Y5gPVdx6xRT1Y1gzjfKcv96/kk3sohg
	 PmM5s2lI+RdCF/2tGIFaxUFH82XRim60rN0jrbRDD76mmgg2rulACaWFjwmXrRSaJ
	 dBE4qIM5YwtFoMlQKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from lisa ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJTC-1uNH7a0lbO-016gsZ; Thu, 31
 Jul 2025 11:23:20 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-pm@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: loading amd-pstate-ut kernel module crashes with PREEMPT_RT
Date: Thu, 31 Jul 2025 11:23:15 +0200
Message-ID: <20250731092316.3191-1-spasswolf@web.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rXPe0oBI10Tnx40njH+dh3CmDHmmmm3O00cyP4DsGG+RJoVoUH2
 uC8cWjrUprFB7KblMiADlOfJPddAU5w3dwrI4WZteyKJ5hCyf3NUg1U50L5DTIs/lu0ZHSq
 kHcEBrPsF1bAYX4lXl9xWEtmr4fiLFKTL95kUCIzj1n2Uur4eA8WqzLpiSAYWL0B/IwWsqm
 Y54cc47LdRsfUQTlP147Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JkVQ0KkBmfY=;yE+LPvz+M1fv0M7lRHdKKoS5fYP
 9HBJJZM6x6WvkO5VLwrcdthd+aJid1Q2ShXnyv1oeF6fqviatpFu9wOj3YJuWlo63lL7ajoim
 d/3Nz/Q27UAu9D6bay2L/fds7nYo1Lo3ssgdbsLixV3xqEKewjBQPnO6Ed90MEKBOKR7Vl9z+
 50Dt5vEI1rKMTUq2nnlg8v+SgJjiuCmNJssowN7UX7fCDeGx2c0GJ8eD+aIauw0rnZpJqmqxP
 9EliI3U/0uMY+ur2mJ0WzpbEdjodE5VD+byInjNSI7fFeNcPZhyHNtjBbg1XsOHbafGwqXwxe
 vVojU+ABo1aJPCGfcXpBi2WMWDrv+kEITpDUZETxSaUkmATmeZB6/688pTehqh4K+de1tkBsu
 jEHMA4gCRbBLyPYlKKuOsDAb8lTHs5cpEqAn2Ip5FfI3SCTQEsJOL1QWDHfKD7eIL+iEYJ7aa
 N4XeZOotqLTGn+ajVb3Ie/imgqtYHWyFHtv74BtOCI1ib7tDEBtenne/+o+lXQ95uji4fqz0Q
 yAtyvVQ7aZFea/KBSTz3dFbZlWRIF1hI65TWa2uvWOurdMK+FhPsyq3dJ2r2WWIwbnX6a4oQ1
 CsuUeNHeAUHue3vRsgEh2YO1QENEMQchq9WK0G8799unrhJS1FwGU3kiFbz7div+MsOX0kfRK
 6zu3gcTe91TkGa3LUB5LYLHb4HRNHvzoDzFFm1oZKXB2xwefx/WtPw8cBdg3TMN0NgPbmPpAC
 ZUD9SzaNEm8rlapbrHgyoXMFXk77nOvV/7Y0S503j++LF0lkytv7JQ0AXWhKrc7grEejZIGd0
 bRlxEITdMplUvycum8Tn1FROuiHQHwDMPK6APC0uWxZjvifZ7gYxJvKKt3+tnzOuD0ob2MSYl
 hEhGlEpTFDBPefCxdGxcGAfcC+p+Ku++skRjYevTsEnVeWOt4gdJa9nV9DG/q3gQTdQoFoxaz
 RHhaDgN9iahCsZ/IUe3GW0ZXv5cfjd/0jR6GqEJPhfEmQ60YX2YABQ1DDei3i+ihR9IMLAFRv
 DzrJzUyrxENWwa5cLQqAXyyWcem13I+U86ANr+FNsEu5js0acGB/pHNuSLLvv4umr6og5mto4
 Rt3xzW7dC9VTOxBbiV5hg70FOMd1qd7kFMnwG30IY4A/QCpRk/CSGGxTqOMHtQyTLhXfpjIkO
 U7xBtH+9q4NCwUf27c5kszDiBT68vAWu4TXvZC5njR1uHdDQNS7b67U9DqYUwE+0IeWMs53aU
 IrwRrVpqFSaUHwE2nqfyZeklRUJm3CRS1JCeMrPN1kQF6ZNjJQaRoJZXU4nBxC6w8Rpm6PB94
 PeVG9+PTfl4q0gtnxvn8yZr+iUmhs4lbIO12s5WFhrskk1TS/eIUzLlfWFtEoj/OIu9KD9M65
 bLXjLPxYqyKD33jzKNrpNzQjNZScGxDnAv/9NtzVyptMmGMGaoWEfu4wOr2M+kEESICxt8JiA
 XBmfzjZT4/F/XCExGiBiWc6t+2xI157spDPRUi3KarkVNZnQsCg9M6TQz2I6juvXV1DJ0mNF6
 GMYdvU9hzJMhGZZ+rwP+3MOk1l+OsWDytpcNhWS8c0m1ALFb9jGgTkbXfPX7HGyYtCzy/lWMa
 CNHdHzSb2KpxBOClTWuINBij2zUHvgvDSDlNGnZqX4cPHsxf6tzMJ0GALtLTRN5Aw5NphNaRt
 KzLSdfuzp+5/hQmD1S7na1/otqDfZe3PNyK5h+ceWariLkezrUslWIVNfQ9PQgib77P1RFwOU
 MZJCXFqyMVrAq7Fdh7hcrCmlySHJI3qXuYUWTB0MHD+fbo3D40IVvxT5n28/PWjLhYtk2SCDj
 LyoJHxpb32cV6uC8kF6wnUGv2RgZ7n+x+S3OYDwN1Y1BS6Qn1UhovCbUsYWcBjq+CYpBVOydE
 qa+aihYy6pb9oNSfN0Jg+RYfbkQwZka/1XoKOls4qq2PLeaWTiaZxln2vk6GsHlbEh5UWCcod
 /kgLKk4ycgyFu2RQuYdsuFD+IiNdxAtH4TnnjeYgXpU4gD27uKc/Q27XFEbVTg6nsABlfLFq2
 zcw4hgc/8nDjV7sY7YfbFkzKDN598InUjEen/gUYo+SURJQOJ3uUqJg3RVqmuXnyS8gKVC8pZ
 eCRSfCmHuXHUL6D6T4zgSrTMril5Q9AL37ybS8V7JKkRgkPQlKD2MQvWWxtMvM56lyHhgIiqK
 FFVdCcLI6Cx9zuKBlrX4V4C7bfpoRnPNPtudoLGTAKSPRRaBHb5Kz0KrMnaLHGyjEQJHP8XiM
 eed9MhUv9RjCOkPAHTB+EcbtjCfxuNR/SSGhLypkiDpS5ucdfSFlqw7Z2QbOQGSY16SQOUAV1
 Y2AMHOoX+YEiMzS2kM4PFY79L7VCHoEcAfPJeASJXqusYjLPqEbFnZQjk3vtIIM5Nowys1SG6
 TsufEalizuAoAKGEudY8pBR+ARU8rf/eO1KUhUjVkbjgbPgTLq5YqUmkZ/TaK0yHzGQ5oWxEB
 gzb9Z6YQfGhUKxt/h+W3GKhrdwGjveNbQoAOVtscNXhHpoVpIKGoN4RJCWvuPYApramcdEQaT
 5Ihdp0Xrh+48Zsl2Inbg1lNODye1j0bhRD4C0GyltkWk0OuMnjo/kqsLDPVLFdJYy2iPp0kfE
 Oje24S6yLfs+hq7Ez/89ryqFrRI/m3cJimpCLXqBVrfnij+AIMjbn5UHeOaqTB4kw82iD/3Ok
 VIxiNqE/K8sEfeJO1nZyZ/SGviBu+Mv4OZV/5HGIrz7SdfmODTJCjYVf5c1oChmNZ44cGCpOx
 yn3Mjcalb8NzY8pfAfeOPsuMzwjEJn22W99I+RfKLPG89ascoZ4ycBuPOb6G4BUgzxVyYKg0T
 qa9NV3cHJwu2qwQeezSmClQIoqWI7CCdfIka+gu0wpAZWnsEe7j8/7Ye1rfGu/6lI/oGKTp1z
 GeCc65COYv49Zkxnj9FxScgsei10YnFcaZ3MJWKxeJb1VULL2ASBBnPZOxYsafBv8KC8wQM9N
 85+tBGgh3faGHxl21x9dM/3f8YutU6/fuV9J8Dh6OTZKKP7fJybYAL4pDONc/UaCnJutPzJkP
 sNBg8w0SmjeaRJM7nSUPm0vKWkjtZ3a+tva+0QmogppaVojK/9zO8bnXANeIQN9LX+HyYeZi4
 ToHimj0PCy1fuoyM6Z4UbMNhZmtletRclhSu/4PoI5Gc7MpL8L8j8YnDejLNY5f+4yyOpe2u3
 72suLpkKv9X6e7UjCLeiqpZp6/peA14XDCMcJUafKiKwF7NpJT8Sfb5pggRi2A7XcmOzzCGOs
 6cng5RtFkO72exFGAhcj9ErZlD1uLDo3mdYEd2KBjpGwVdmxdCAIAIBx1XH1iQqRxKPMZsbO4
 6vkI26aTsONxt+8tRM0nMM2yMFN4/IXbbbVCvSa1JEkNva/EKgY00r7pakTwqknXPuYYJgqyd
 9ceIlRomnJnt9fndTae8U/HPtVP7+7p669feh1YCRX4oarc42i8mtzEjrfcX0sVfCcVh04ehZ
 phTENH9mI6HihpuT90+QD7663xOP5Zm961L1sU8pCrDFNbkb21qwzpYgAxyD3+FP+H5DHED+8
 yw==

When loading the amd-pstate-ut kernel module (which is supposed to test
the amd-pstate cpufreq driver) the following crash occurs (most of the=20
time the loading has to be repeated several times):

Log from 6.16.0 with PREEMPT_RT (captured via netconsole):
Jul 30 19:11:59 localhost 15,1193,53902050,-,caller=3DT3076;netconsole-set=
up: Test log message to verify netconsole configuration.
Jul 30 19:12:07 localhost 6,1194,62487297,-,caller=3DT3115;amd_pstate_ut: =
1    amd_pstate_ut_acpi_cpc_valid\x09 success!
Jul 30 19:12:07 localhost 6,1195,62487302,-,caller=3DT3115;amd_pstate_ut: =
2    amd_pstate_ut_check_enabled\x09 success!
Jul 30 19:12:07 localhost 6,1196,62487507,-,caller=3DT3115;amd_pstate_ut: =
3    amd_pstate_ut_check_perf\x09 success!
Jul 30 19:12:07 localhost 6,1197,62487510,-,caller=3DT3115;amd_pstate_ut: =
4    amd_pstate_ut_check_freq\x09 success!
Jul 30 19:12:08 localhost 6,1198,63369470,-,caller=3DT3115;amd_pstate_ut: =
5    amd_pstate_ut_check_driver\x09 success!
Jul 30 19:12:12 localhost 6,1199,67167450,-,caller=3DT3118;amd_pstate_ut: =
1    amd_pstate_ut_acpi_cpc_valid\x09 success!
Jul 30 19:12:12 localhost 6,1200,67167455,-,caller=3DT3118;amd_pstate_ut: =
2    amd_pstate_ut_check_enabled\x09 success!
Jul 30 19:12:12 localhost 6,1201,67167687,-,caller=3DT3118;amd_pstate_ut: =
3    amd_pstate_ut_check_perf\x09 success!
Jul 30 19:12:12 localhost 6,1202,67167691,-,caller=3DT3118;amd_pstate_ut: =
4    amd_pstate_ut_check_freq\x09 success!
Jul 30 19:12:13 localhost 6,1203,68061094,-,caller=3DT3118;amd_pstate_ut: =
5    amd_pstate_ut_check_driver\x09 success!
Jul 30 19:12:15 localhost 6,1204,69813892,-,caller=3DT3120;amd_pstate_ut: =
1    amd_pstate_ut_acpi_cpc_valid\x09 success!
Jul 30 19:12:15 localhost 6,1205,69813896,-,caller=3DT3120;amd_pstate_ut: =
2    amd_pstate_ut_check_enabled\x09 success!
Jul 30 19:12:15 localhost 6,1206,69814122,-,caller=3DT3120;amd_pstate_ut: =
3    amd_pstate_ut_check_perf\x09 success!
Jul 30 19:12:15 localhost 6,1207,69814126,-,caller=3DT3120;amd_pstate_ut: =
4    amd_pstate_ut_check_freq\x09 success!
Jul 30 19:12:16 localhost 3,1208,70350248,-,caller=3DT0;BUG: scheduling wh=
ile atomic: swapper/4/0/0x00000005
Jul 30 19:12:16 localhost 3,1209,70350250,-,caller=3DT0;BUG: scheduling wh=
ile atomic: swapper/0/0/0x00000005
Jul 30 19:12:16 localhost 4,1210,70350253,-,caller=3DT0;Modules linked in:
Jul 30 19:12:16 localhost 4,1211,70350255,-,caller=3DT0;Modules linked in:=
 amd_pstate_ut(+)
Jul 30 19:12:16 localhost 4,1212,70350256,c,caller=3DT0; amd_pstate_ut(+) =
netconsole
Jul 30 19:12:16 localhost 4,1213,70350259,c,caller=3DT0; netconsole ccm
Jul 30 19:12:16 localhost 4,1214,70350260,c,caller=3DT0; ccm snd_seq_dummy
Jul 30 19:12:16 localhost 4,1215,70350263,c,caller=3DT0; snd_seq_dummy snd=
_hrtimer
Jul 30 19:12:16 localhost 4,1216,70350264,c,caller=3DT0; snd_hrtimer snd_s=
eq_midi
Jul 30 19:12:16 localhost 4,1217,70350265,c,caller=3DT0; snd_seq_midi snd_=
seq_midi_event snd_seq_midi_event
Jul 30 19:12:16 localhost 4,1218,70350266,c,caller=3DT0; snd_rawmidi snd_r=
awmidi
Jul 30 19:12:16 localhost 4,1219,70350267,c,caller=3DT0; snd_seq snd_seq
Jul 30 19:12:16 localhost 4,1220,70350269,c,caller=3DT0; snd_seq_device sn=
d_seq_device
Jul 30 19:12:16 localhost 4,1221,70350270,c,caller=3DT0; rfcomm bnep rfcom=
m nls_ascii bnep
Jul 30 19:12:16 localhost 4,1222,70350273,c,caller=3DT0; nls_cp437 vfat
Jul 30 19:12:16 localhost 4,1223,70350275,c,caller=3DT0; nls_ascii fat
Jul 30 19:12:16 localhost 4,1224,70350276,c,caller=3DT0; nls_cp437 snd_ctl=
_led
Jul 30 19:12:16 localhost 4,1225,70350278,c,caller=3DT0; vfat snd_hda_code=
c_realtek
Jul 30 19:12:16 localhost 4,1226,70350279,c,caller=3DT0; fat snd_hda_codec=
_generic
Jul 30 19:12:16 localhost 4,1227,70350280,c,caller=3DT0; snd_ctl_led snd_h=
da_scodec_component
Jul 30 19:12:16 localhost 4,1228,70350281,c,caller=3DT0; snd_hda_codec_rea=
ltek
Jul 30 19:12:16 localhost 4,1229,70350281,c,caller=3DT0; snd_hda_codec_hdm=
i
Jul 30 19:12:16 localhost 4,1230,70350283,c,caller=3DT0; snd_hda_codec_gen=
eric btusb
Jul 30 19:12:16 localhost 4,1231,70350283,c,caller=3DT0; snd_hda_scodec_co=
mponent snd_hda_codec_hdmi
Jul 30 19:12:16 localhost 4,1232,70350283,c,caller=3DT0; btrtl btintel
Jul 30 19:12:16 localhost 4,1233,70350285,c,caller=3DT0; btusb btrtl snd_h=
da_intel btintel btbcm snd_hda_intel btmtk
Jul 30 19:12:16 localhost 4,1234,70350289,c,caller=3DT0; btbcm snd_intel_d=
spcfg
Jul 30 19:12:16 localhost 4,1235,70350290,c,caller=3DT0; btmtk snd_intel_d=
spcfg
Jul 30 19:12:16 localhost 4,1236,70350290,c,caller=3DT0; snd_hda_codec
Jul 30 19:12:16 localhost 4,1237,70350292,c,caller=3DT0; snd_hda_codec snd=
_acp3x_pdm_dma snd_acp3x_pdm_dma snd_soc_dmic snd_soc_dmic snd_acp3x_rn
Jul 30 19:12:16 localhost 4,1238,70350295,c,caller=3DT0; snd_acp3x_rn uvcv=
ideo uvcvideo snd_hwdep snd_hwdep videobuf2_vmalloc
Jul 30 19:12:16 localhost 4,1239,70350297,c,caller=3DT0; videobuf2_vmalloc=
 videobuf2_memops videobuf2_memops bluetooth bluetooth snd_soc_core
Jul 30 19:12:16 localhost 4,1240,70350300,c,caller=3DT0; snd_soc_core snd_=
hda_core
Jul 30 19:12:16 localhost 4,1241,70350301,c,caller=3DT0; snd_hda_core uvc
Jul 30 19:12:16 localhost 4,1242,70350302,c,caller=3DT0; uvc videobuf2_v4l=
2
Jul 30 19:12:16 localhost 4,1243,70350302,c,caller=3DT0; videobuf2_v4l2 sn=
d_pcm_oss
Jul 30 19:12:16 localhost 4,1244,70350304,c,caller=3DT0; snd_pcm_oss video=
dev
Jul 30 19:12:16 localhost 4,1245,70350304,c,caller=3DT0; videodev snd_mixe=
r_oss
Jul 30 19:12:16 localhost 4,1246,70350307,c,caller=3DT0; snd_mixer_oss snd=
_pcm
Jul 30 19:12:16 localhost 4,1247,70350307,c,caller=3DT0; snd_pcm snd_rn_pc=
i_acp3x
Jul 30 19:12:16 localhost 4,1248,70350309,c,caller=3DT0; snd_rn_pci_acp3x =
snd_acp_config
Jul 30 19:12:16 localhost 4,1249,70350309,c,caller=3DT0; snd_acp_config vi=
deobuf2_common
Jul 30 19:12:16 localhost 4,1250,70350311,c,caller=3DT0; videobuf2_common =
snd_timer
Jul 30 19:12:16 localhost 4,1251,70350311,c,caller=3DT0; snd_timer snd_soc=
_acpi
Jul 30 19:12:16 localhost 4,1252,70350313,c,caller=3DT0; snd_soc_acpi msi_=
wmi
Jul 30 19:12:16 localhost 4,1253,70350313,c,caller=3DT0; msi_wmi ecdh_gene=
ric
Jul 30 19:12:16 localhost 4,1254,70350315,c,caller=3DT0; ecdh_generic ecc
Jul 30 19:12:16 localhost 4,1255,70350316,c,caller=3DT0; ecc mc
Jul 30 19:12:16 localhost 4,1256,70350316,c,caller=3DT0; mc sparse_keymap
Jul 30 19:12:16 localhost 4,1257,70350319,c,caller=3DT0; sparse_keymap wmi=
_bmof
Jul 30 19:12:16 localhost 4,1258,70350318,c,caller=3DT0; wmi_bmof edac_mce=
_amd
Jul 30 19:12:16 localhost 4,1259,70350321,c,caller=3DT0; edac_mce_amd snd
Jul 30 19:12:16 localhost 4,1260,70350321,c,caller=3DT0; snd k10temp
Jul 30 19:12:16 localhost 4,1261,70350322,c,caller=3DT0; k10temp ccp
Jul 30 19:12:16 localhost 4,1262,70350324,c,caller=3DT0; ccp soundcore
Jul 30 19:12:16 localhost 4,1263,70350324,c,caller=3DT0; soundcore snd_pci=
_acp3x
Jul 30 19:12:16 localhost 4,1264,70350326,c,caller=3DT0; snd_pci_acp3x ac
Jul 30 19:12:16 localhost 4,1265,70350327,c,caller=3DT0; ac battery
Jul 30 19:12:16 localhost 4,1266,70350327,c,caller=3DT0; battery button
Jul 30 19:12:16 localhost 4,1267,70350329,c,caller=3DT0; button joydev
Jul 30 19:12:16 localhost 4,1268,70350329,c,caller=3DT0; joydev hid_sensor=
_prox
Jul 30 19:12:16 localhost 4,1269,70350332,c,caller=3DT0; hid_sensor_prox h=
id_sensor_magn_3d
Jul 30 19:12:16 localhost 4,1270,70350333,c,caller=3DT0; hid_sensor_magn_3=
d hid_sensor_accel_3d
Jul 30 19:12:16 localhost 4,1271,70350334,c,caller=3DT0; hid_sensor_accel_=
3d hid_sensor_gyro_3d
Jul 30 19:12:16 localhost 4,1272,70350335,c,caller=3DT0; hid_sensor_gyro_3=
d hid_sensor_als
Jul 30 19:12:16 localhost 4,1273,70350336,c,caller=3DT0; hid_sensor_als hi=
d_sensor_trigger
Jul 30 19:12:16 localhost 4,1274,70350336,c,caller=3DT0; hid_sensor_trigge=
r evdev
Jul 30 19:12:16 localhost 4,1275,70350338,c,caller=3DT0; evdev industriali=
o_triggered_buffer
Jul 30 19:12:16 localhost 4,1276,70350338,c,caller=3DT0; industrialio_trig=
gered_buffer kfifo_buf
Jul 30 19:12:16 localhost 4,1277,70350339,c,caller=3DT0; kfifo_buf industr=
ialio
Jul 30 19:12:16 localhost 4,1278,70350342,c,caller=3DT0; industrialio amd_=
pmc
Jul 30 19:12:16 localhost 4,1279,70350342,c,caller=3DT0; amd_pmc hid_senso=
r_iio_common
Jul 30 19:12:16 localhost 4,1280,70350344,c,caller=3DT0; hid_sensor_iio_co=
mmon mt7921e
Jul 30 19:12:16 localhost 4,1281,70350344,c,caller=3DT0; mt7921e mt7921_co=
mmon
Jul 30 19:12:16 localhost 4,1282,70350345,c,caller=3DT0; mt7921_common mt7=
92x_lib
Jul 30 19:12:16 localhost 4,1283,70350346,c,caller=3DT0; mt792x_lib mt76_c=
onnac_lib
Jul 30 19:12:16 localhost 4,1284,70350348,c,caller=3DT0; mt76_connac_lib m=
t76
Jul 30 19:12:16 localhost 4,1285,70350348,c,caller=3DT0; mt76 mac80211
Jul 30 19:12:16 localhost 4,1286,70350349,c,caller=3DT0; mac80211 libarc4
Jul 30 19:12:16 localhost 4,1287,70350351,c,caller=3DT0; libarc4 cfg80211
Jul 30 19:12:16 localhost 4,1288,70350351,c,caller=3DT0; cfg80211 rfkill
Jul 30 19:12:16 localhost 4,1289,70350353,c,caller=3DT0; rfkill msr
Jul 30 19:12:16 localhost 4,1290,70350353,c,caller=3DT0; msr fuse
Jul 30 19:12:16 localhost 4,1291,70350355,c,caller=3DT0; fuse nvme_fabrics
Jul 30 19:12:16 localhost 4,1292,70350356,c,caller=3DT0; nvme_fabrics efi_=
pstore
Jul 30 19:12:16 localhost 4,1293,70350355,c,caller=3DT0; efi_pstore config=
fs
Jul 30 19:12:16 localhost 4,1294,70350357,c,caller=3DT0; configfs efivarfs
Jul 30 19:12:16 localhost 4,1295,70350357,c,caller=3DT0; efivarfs autofs4
Jul 30 19:12:16 localhost 4,1296,70350358,c,caller=3DT0; autofs4 ext4
Jul 30 19:12:16 localhost 4,1297,70350360,c,caller=3DT0; ext4 mbcache
Jul 30 19:12:16 localhost 4,1298,70350360,c,caller=3DT0; mbcache jbd2
Jul 30 19:12:16 localhost 4,1299,70350362,c,caller=3DT0; jbd2 usbhid
Jul 30 19:12:16 localhost 4,1300,70350362,c,caller=3DT0; usbhid amdgpu
Jul 30 19:12:16 localhost 4,1301,70350365,c,caller=3DT0; amdgpu drm_client=
_lib
Jul 30 19:12:16 localhost 4,1302,70350364,c,caller=3DT0; drm_client_lib i2=
c_algo_bit
Jul 30 19:12:16 localhost 4,1303,70350366,c,caller=3DT0; i2c_algo_bit drm_=
ttm_helper
Jul 30 19:12:16 localhost 4,1304,70350366,c,caller=3DT0; drm_ttm_helper tt=
m
Jul 30 19:12:16 localhost 4,1305,70350368,c,caller=3DT0; ttm drm_panel_bac=
klight_quirks
Jul 30 19:12:16 localhost 4,1306,70350368,c,caller=3DT0; drm_panel_backlig=
ht_quirks drm_exec
Jul 30 19:12:16 localhost 4,1307,70350370,c,caller=3DT0; drm_exec drm_suba=
lloc_helper
Jul 30 19:12:16 localhost 4,1308,70350369,c,caller=3DT0; drm_suballoc_help=
er cec
Jul 30 19:12:16 localhost 4,1309,70350371,c,caller=3DT0; cec xhci_pci
Jul 30 19:12:16 localhost 4,1310,70350371,c,caller=3DT0; xhci_pci amdxcp
Jul 30 19:12:16 localhost 4,1311,70350373,c,caller=3DT0; amdxcp drm_buddy
Jul 30 19:12:16 localhost 4,1312,70350372,c,caller=3DT0; drm_buddy hid_sen=
sor_hub
Jul 30 19:12:16 localhost 4,1313,70350373,c,caller=3DT0; hid_sensor_hub xh=
ci_hcd
Jul 30 19:12:16 localhost 4,1314,70350375,c,caller=3DT0; xhci_hcd mfd_core
Jul 30 19:12:16 localhost 4,1315,70350374,c,caller=3DT0; mfd_core gpu_sche=
d
Jul 30 19:12:16 localhost 4,1316,70350376,c,caller=3DT0; gpu_sched hid_mul=
titouch
Jul 30 19:12:16 localhost 4,1317,70350377,c,caller=3DT0; hid_multitouch hi=
d_generic
Jul 30 19:12:16 localhost 4,1318,70350378,c,caller=3DT0; hid_generic psmou=
se
Jul 30 19:12:16 localhost 4,1319,70350377,c,caller=3DT0; psmouse drm_displ=
ay_helper
Jul 30 19:12:16 localhost 4,1320,70350379,c,caller=3DT0; drm_display_helpe=
r i2c_hid_acpi
Jul 30 19:12:16 localhost 4,1321,70350380,c,caller=3DT0; i2c_hid_acpi usbc=
ore
Jul 30 19:12:16 localhost 4,1322,70350380,c,caller=3DT0; usbcore amd_sfh
Jul 30 19:12:16 localhost 4,1323,70350381,c,caller=3DT0; amd_sfh nvme
Jul 30 19:12:16 localhost 4,1324,70350382,c,caller=3DT0; nvme i2c_hid
Jul 30 19:12:16 localhost 4,1325,70350383,c,caller=3DT0; i2c_hid drm_kms_h=
elper
Jul 30 19:12:16 localhost 4,1326,70350382,c,caller=3DT0; drm_kms_helper hi=
d
Jul 30 19:12:16 localhost 4,1327,70350384,c,caller=3DT0; hid serio_raw
Jul 30 19:12:16 localhost 4,1328,70350384,c,caller=3DT0; serio_raw r8169
Jul 30 19:12:16 localhost 4,1329,70350384,c,caller=3DT0; r8169 nvme_core
Jul 30 19:12:16 localhost 4,1330,70350386,c,caller=3DT0; nvme_core crc16
Jul 30 19:12:16 localhost 4,1331,70350387,c,caller=3DT0; crc16 usb_common
Jul 30 19:12:16 localhost 4,1332,70350388,c,caller=3DT0; usb_common i2c_pi=
ix4
Jul 30 19:12:16 localhost 4,1333,70350387,c,caller=3DT0; i2c_piix4 i2c_smb=
us
Jul 30 19:12:16 localhost 4,1334,70350389,c,caller=3DT0; i2c_smbus i2c_des=
ignware_platform
Jul 30 19:12:16 localhost 4,1335,70350389,c,caller=3DT0; i2c_designware_pl=
atform i2c_designware_core
Jul 30 19:12:16 localhost 4,1336,70350391,c,caller=3DT0; i2c_designware_co=
re [last unloaded: amd_pstate_ut]
Jul 30 19:12:16 localhost 4,1337,70350390,c,caller=3DT0; [last unloaded: a=
md_pstate_ut]
Jul 30 19:12:16 localhost 4,1338,70350391,c,caller=3DT0;=20
Jul 30 19:12:16 localhost 3,1339,70350392,-,caller=3DT0;Preemption disable=
d at:
Jul 30 19:12:16 localhost 3,1340,70350393,-,caller=3DT0;Preemption disable=
d at:
Jul 30 19:12:16 localhost 3,1341,70350393,-,caller=3DT0;[<ffffffffac32438d=
>] schedule_preempt_disabled+0x1d/0x30
Jul 30 19:12:16 localhost 3,1342,70350392,-,caller=3DT0;[<ffffffffabaccd27=
>] migrate_enable+0x87/0xf0
Jul 30 19:12:16 localhost 4,1343,70350399,-,caller=3DT0;CPU: 4 UID: 0 PID:=
 0 Comm: swapper/4 Not tainted 6.16.0-stable #856 PREEMPT_{RT,(full)}=20
Jul 30 19:12:16 localhost 4,1344,70350401,-,caller=3DT0;Hardware name: Mic=
ro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F =
11/11/2024
Jul 30 19:12:16 localhost 4,1345,70350403,-,caller=3DT0;Call Trace:
Jul 30 19:12:16 localhost 4,1346,70350405,-,caller=3DT0; <IRQ>
Jul 30 19:12:16 localhost 4,1347,70350407,-,caller=3DT0; dump_stack_lvl+0x=
4b/0x70
Jul 30 19:12:16 localhost 4,1348,70350410,-,caller=3DT0; ? migrate_enable+=
0x87/0xf0
Jul 30 19:12:16 localhost 4,1349,70350412,-,caller=3DT0; __schedule_bug.co=
ld+0x73/0x80
Jul 30 19:12:16 localhost 4,1350,70350415,-,caller=3DT0; __schedule+0xf8a/=
0x1340
Jul 30 19:12:16 localhost 4,1351,70350417,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 19:12:16 localhost 4,1352,70350419,-,caller=3DT0; ? migrate_enable+=
0xca/0xf0
Jul 30 19:12:16 localhost 4,1353,70350421,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 19:12:16 localhost 4,1354,70350423,-,caller=3DT0; ? rt_read_unlock+=
0x2f/0x1a0
Jul 30 19:12:16 localhost 4,1355,70350424,-,caller=3DT0; ? rt_read_lock+0x=
40/0xf0
Jul 30 19:12:16 localhost 4,1356,70350426,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 19:12:16 localhost 4,1357,70350428,-,caller=3DT0; schedule_rtlock+0=
x21/0x40
Jul 30 19:12:16 localhost 4,1358,70350431,-,caller=3DT0; rtlock_slowlock_l=
ocked+0x316/0xed0
Jul 30 19:12:16 localhost 4,1359,70350433,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 19:12:16 localhost 4,1360,70350435,-,caller=3DT0; ? sched_clock_cpu=
+0x62/0x1e0
Jul 30 19:12:16 localhost 4,1361,70350439,-,caller=3DT0; rt_read_lock+0x86=
/0xf0
Jul 30 19:12:16 localhost 4,1362,70350441,-,caller=3DT0; cpufreq_cpu_get+0=
x1c/0x70
Jul 30 19:12:16 localhost 4,1363,70350445,-,caller=3DT0; amd_pstate_update=
+0x30/0xf0
Jul 30 19:12:16 localhost 4,1364,70350448,-,caller=3DT0; amd_pstate_adjust=
_perf+0xd4/0x100
Jul 30 19:12:16 localhost 4,1365,70350450,-,caller=3DT0; sugov_update_sing=
le_perf+0x102/0x180
Jul 30 19:12:16 localhost 4,1366,70350453,-,caller=3DT0; update_load_avg+0=
x6d1/0x6e0
Jul 30 19:12:16 localhost 4,1367,70350456,-,caller=3DT0; enqueue_entity+0x=
31/0x320
Jul 30 19:12:16 localhost 4,1368,70350458,-,caller=3DT0; enqueue_task_fair=
+0x123/0x660
Jul 30 19:12:16 localhost 4,1369,70350460,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 19:12:16 localhost 4,1370,70350462,-,caller=3DT0; ? profile_tick+0x=
2f/0x70
Jul 30 19:12:16 localhost 4,1371,70350464,-,caller=3DT0; enqueue_task+0x30=
/0x110
Jul 30 19:12:16 localhost 4,1372,70350467,-,caller=3DT0; ttwu_do_activate+=
0x6a/0x1b0
Jul 30 19:12:16 localhost 4,1373,70350470,-,caller=3DT0; try_to_wake_up+0x=
292/0x4e0
Jul 30 19:12:16 localhost 4,1374,70350472,-,caller=3DT0; __irq_exit_rcu+0x=
d9/0x120
Jul 30 19:12:16 localhost 4,1375,70350475,-,caller=3DT0; sysvec_apic_timer=
_interrupt+0x8d/0xb0
Jul 30 19:12:16 localhost 4,1376,70350478,-,caller=3DT0; </IRQ>
Jul 30 19:12:16 localhost 4,1377,70350479,-,caller=3DT0; <TASK>
Jul 30 19:12:16 localhost 4,1378,70350480,-,caller=3DT0; asm_sysvec_apic_t=
imer_interrupt+0x1a/0x20
Jul 30 19:12:16 localhost 4,1379,70350482,-,caller=3DT0;RIP: 0010:cpuidle_=
enter_state+0xab/0x2b0
Jul 30 19:12:16 localhost 4,1380,70350484,-,caller=3DT0;Code: 45 40 40 0f =
84 0a 01 00 00 e8 e1 05 7d ff e8 9c f2 ff ff 31 ff 49 89 c5 e8 d2 16 7c ff=
 45 84 ff 0f 85 e1 00 00 00 fb 45 85 f6 <0f> 88 c1 00 00 00 48 8b 04 24 49=
 63 f6 48 6b ce 68 49 29 c5 48 89
Jul 30 19:12:16 localhost 4,1381,70350485,-,caller=3DT0;RSP: 0018:fffface4=
801d7e78 EFLAGS: 00000202
Jul 30 19:12:16 localhost 4,1382,70350487,-,caller=3DT0;RAX: ffff8b26f194b=
000 RBX: ffff8b23c5942800 RCX: 0000001061336233
Jul 30 19:12:16 localhost 4,1383,70350488,-,caller=3DT0;RDX: 0000001061336=
233 RSI: ffffffffac6b1014 RDI: ffffffffac6b2e6e
Jul 30 19:12:16 localhost 4,1384,70350489,-,caller=3DT0;RBP: 0000000000000=
001 R08: 0000000000000000 R09: 000001d1a94a2000
Jul 30 19:12:16 localhost 4,1385,70350490,-,caller=3DT0;R10: 0000000000000=
003 R11: 00000000000019a9 R12: ffffffffac8c7a20
Jul 30 19:12:16 localhost 4,1386,70350491,-,caller=3DT0;R13: 0000001061336=
233 R14: 0000000000000001 R15: 0000000000000000
Jul 30 19:12:16 localhost 4,1387,70350494,-,caller=3DT0; ? cpuidle_enter_s=
tate+0x9e/0x2b0
Jul 30 19:12:16 localhost 4,1388,70350496,-,caller=3DT0; cpuidle_enter+0x2=
8/0x40
Jul 30 19:12:16 localhost 4,1389,70350499,-,caller=3DT0; do_idle+0x1c2/0x2=
40
Jul 30 19:12:16 localhost 4,1390,70350502,-,caller=3DT0; cpu_startup_entry=
+0x24/0x30
Jul 30 19:12:16 localhost 4,1391,70350503,-,caller=3DT0; start_secondary+0=
x112/0x130
Jul 30 19:12:16 localhost 4,1392,70350506,-,caller=3DT0; common_startup_64=
+0x13e/0x148
Jul 30 19:12:16 localhost 4,1393,70350511,-,caller=3DT0; </TASK>
Jul 30 19:12:16 localhost 4,1394,70350514,-,caller=3DT0;CPU: 0 UID: 0 PID:=
 0 Comm: swapper/0 Tainted: G        W           6.16.0-stable #856 PREEMP=
T_{RT,(full)}=20
Jul 30 19:12:16 localhost 4,1395,70350517,-,caller=3DT0;Tainted: [W]=3DWAR=
N
Jul 30 19:12:16 localhost 4,1396,70350517,-,caller=3DT0;Hardware name: Mic=
ro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F =
11/11/2024
Jul 30 19:12:16 localhost 4,1397,70350518,-,caller=3DT0;Call Trace:
Jul 30 19:12:16 localhost 4,1398,70350519,-,caller=3DT0; <IRQ>
Jul 30 19:12:16 localhost 4,1399,70350521,-,caller=3DT0; dump_stack_lvl+0x=
4b/0x70
Jul 30 19:12:16 localhost 4,1400,70350523,-,caller=3DT0; ? schedule_preemp=
t_disabled+0x1d/0x30
Jul 30 19:12:16 localhost 4,1401,70350525,-,caller=3DT0; __schedule_bug.co=
ld+0x73/0x80
Jul 30 19:12:16 localhost 4,1402,70350527,-,caller=3DT0; __schedule+0xf8a/=
0x1340
Jul 30 19:12:16 localhost 4,1403,70350529,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 19:12:16 localhost 4,1404,70350530,-,caller=3DT0; ? migrate_enable+=
0xca/0xf0
Jul 30 19:12:16 localhost 4,1405,70350533,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 19:12:16 localhost 4,1406,70350534,-,caller=3DT0; ? rt_read_unlock+=
0x2f/0x1a0
Jul 30 19:12:16 localhost 4,1407,70350536,-,caller=3DT0; ? rt_read_lock+0x=
40/0xf0
Jul 30 19:12:16 localhost 4,1408,70350537,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 19:12:16 localhost 4,1409,70350540,-,caller=3DT0; schedule_rtlock+0=
x21/0x40
Jul 30 19:12:16 localhost 4,1410,70350541,-,caller=3DT0; rtlock_slowlock_l=
ocked+0x316/0xed0
Jul 30 19:12:16 localhost 4,1411,70350544,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 19:12:16 localhost 4,1412,70350545,-,caller=3DT0; ? sched_clock_cpu=
+0x62/0x1e0
Jul 30 19:12:16 localhost 4,1413,70350549,-,caller=3DT0; rt_read_lock+0x86=
/0xf0
Jul 30 19:12:16 localhost 4,1414,70350551,-,caller=3DT0; cpufreq_cpu_get+0=
x1c/0x70
Jul 30 19:12:16 localhost 4,1415,70350553,-,caller=3DT0; amd_pstate_update=
+0x30/0xf0
Jul 30 19:12:16 localhost 4,1416,70350556,-,caller=3DT0; amd_pstate_adjust=
_perf+0xd4/0x100
Jul 30 19:12:16 localhost 4,1417,70350558,-,caller=3DT0; sugov_update_sing=
le_perf+0x102/0x180
Jul 30 19:12:16 localhost 4,1418,70350560,-,caller=3DT0; update_load_avg+0=
x6d1/0x6e0
Jul 30 19:12:16 localhost 4,1419,70350563,-,caller=3DT0; enqueue_entity+0x=
31/0x320
Jul 30 19:12:16 localhost 4,1420,70350565,-,caller=3DT0; enqueue_task_fair=
+0x123/0x660
Jul 30 19:12:16 localhost 4,1421,70350567,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 19:12:16 localhost 4,1422,70350569,-,caller=3DT0; ? profile_tick+0x=
2f/0x70
Jul 30 19:12:16 localhost 4,1423,70350571,-,caller=3DT0; enqueue_task+0x30=
/0x110
Jul 30 19:12:16 localhost 4,1424,70350573,-,caller=3DT0; ttwu_do_activate+=
0x6a/0x1b0
Jul 30 19:12:16 localhost 4,1425,70350575,-,caller=3DT0; try_to_wake_up+0x=
292/0x4e0
Jul 30 19:12:16 localhost 4,1426,70350578,-,caller=3DT0; __irq_exit_rcu+0x=
d9/0x120
Jul 30 19:12:16 localhost 4,1427,70350580,-,caller=3DT0; sysvec_apic_timer=
_interrupt+0x8d/0xb0
Jul 30 19:12:16 localhost 4,1428,70350583,-,caller=3DT0; </IRQ>
Jul 30 19:12:16 localhost 4,1429,70350583,-,caller=3DT0; <TASK>
Jul 30 19:12:16 localhost 4,1430,70350584,-,caller=3DT0; asm_sysvec_apic_t=
imer_interrupt+0x1a/0x20
Jul 30 19:12:16 localhost 4,1431,70350586,-,caller=3DT0;RIP: 0010:cpuidle_=
enter_state+0xab/0x2b0
Jul 30 19:12:16 localhost 4,1432,70350587,-,caller=3DT0;Code: 45 40 40 0f =
84 0a 01 00 00 e8 e1 05 7d ff e8 9c f2 ff ff 31 ff 49 89 c5 e8 d2 16 7c ff=
 45 84 ff 0f 85 e1 00 00 00 fb 45 85 f6 <0f> 88 c1 00 00 00 48 8b 04 24 49=
 63 f6 48 6b ce 68 49 29 c5 48 89
Jul 30 19:12:16 localhost 4,1433,70350589,-,caller=3DT0;RSP: 0018:ffffffff=
ac803e20 EFLAGS: 00000202
Jul 30 19:12:16 localhost 4,1434,70350590,-,caller=3DT0;RAX: ffff8b26f184b=
000 RBX: ffff8b23c2206c00 RCX: 000000106133622a
Jul 30 19:12:16 localhost 4,1435,70350591,-,caller=3DT0;RDX: 0000001061336=
22a RSI: ffffffffac6b1014 RDI: ffffffffac6b2e6e
Jul 30 19:12:16 localhost 4,1436,70350592,-,caller=3DT0;RBP: 0000000000000=
001 R08: 0000000000000000 R09: 000001d1a94a2000
Jul 30 19:12:16 localhost 4,1437,70350593,-,caller=3DT0;R10: 0000000000000=
003 R11: 000000000000189a R12: ffffffffac8c7a20
Jul 30 19:12:16 localhost 4,1438,70350594,-,caller=3DT0;R13: 0000001061336=
22a R14: 0000000000000001 R15: 0000000000000000
Jul 30 19:12:16 localhost 4,1439,70350597,-,caller=3DT0; cpuidle_enter+0x2=
8/0x40
Jul 30 19:12:16 localhost 4,1440,70350599,-,caller=3DT0; do_idle+0x1c2/0x2=
40
Jul 30 19:12:16 localhost 4,1441,70350602,-,caller=3DT0; cpu_startup_entry=
+0x24/0x30
Jul 30 19:12:16 localhost 4,1442,70350603,-,caller=3DT0; rest_init+0xb8/0x=
c0
Jul 30 19:12:16 localhost 4,1443,70350605,-,caller=3DT0; start_kernel+0x89=
6/0x8a0
Jul 30 19:12:16 localhost 4,1444,70350609,-,caller=3DT0; x86_64_start_rese=
rvations+0x24/0x30
Jul 30 19:12:16 localhost 4,1445,70350612,-,caller=3DT0; x86_64_start_kern=
el+0xc6/0xd0
Jul 30 19:12:16 localhost 4,1446,70350614,-,caller=3DT0; common_startup_64=
+0x13e/0x148
Jul 30 19:12:16 localhost 4,1447,70350618,-,caller=3DT0; </TASK>
Jul 30 19:12:16 localhost 4,1448,71444259,-,caller=3DC11;[drm] Fence fallb=
ack timer expired on ring comp_1.1.0
Jul 30 19:12:16 localhost 4,1449,71452256,-,caller=3DC11;[drm] Fence fallb=
ack timer expired on ring sdma0
Jul 30 19:12:17 localhost 4,1450,71948258,-,caller=3DC10;[drm] Fence fallb=
ack timer expired on ring comp_1.1.0
Jul 30 19:12:17 localhost 4,1451,72453257,-,caller=3DC14;[drm] Fence fallb=
ack timer expired on ring comp_1.1.0
Jul 30 19:12:18 localhost 4,1452,72956257,-,caller=3DC12;[drm] Fence fallb=
ack timer expired on ring comp_1.1.0
Jul 30 19:12:18 localhost 4,1453,72956262,-,caller=3DC2;[drm] Fence fallba=
ck timer expired on ring gfx
Jul 30 19:12:18 localhost 4,1454,73460258,-,caller=3DC14;[drm] Fence fallb=
ack timer expired on ring gfx
Jul 30 19:12:19 localhost 4,1455,73964256,-,caller=3DC12;[drm] Fence fallb=
ack timer expired on ring gfx
Jul 30 19:12:19 localhost 4,1456,74468255,-,caller=3DC14;[drm] Fence fallb=
ack timer expired on ring gfx
Jul 30 19:12:20 localhost 4,1457,75198257,-,caller=3DC15;[drm] Fence fallb=
ack timer expired on ring gfx

Log from 6.16.0 with PREEMPT_RT and CONFIG_LOCKDEP (captured via netconsol=
e):
Jul 30 23:15:25 localhost 15,1253,92127003,-,caller=3DT3190;netconsole-set=
up: Test log message to verify netconsole configuration.
Jul 30 23:15:28 localhost 6,1254,95294787,-,caller=3DT3228;amd_pstate_ut: =
1    amd_pstate_ut_acpi_cpc_valid\x09 success!
Jul 30 23:15:28 localhost 6,1255,95294791,-,caller=3DT3228;amd_pstate_ut: =
2    amd_pstate_ut_check_enabled\x09 success!
Jul 30 23:15:28 localhost 6,1256,95295373,-,caller=3DT3228;amd_pstate_ut: =
3    amd_pstate_ut_check_perf\x09 success!
Jul 30 23:15:28 localhost 6,1257,95295383,-,caller=3DT3228;amd_pstate_ut: =
4    amd_pstate_ut_check_freq\x09 success!
Jul 30 23:15:28 localhost 4,1258,95314275,-,caller=3DT0;=20
Jul 30 23:15:28 localhost 4,1259,95314277,-,caller=3DT0;=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
Jul 30 23:15:28 localhost 4,1260,95314278,-,caller=3DT0;[ BUG: Invalid wai=
t context ]
Jul 30 23:15:28 localhost 4,1261,95314279,-,caller=3DT0;6.16.0-lockdep #86=
1 Not tainted
Jul 30 23:15:28 localhost 4,1262,95314280,-,caller=3DT0;------------------=
=2D----------=20
Jul 30 23:15:28 localhost 4,1263,95314281,-,caller=3DT0;swapper/0/0 is try=
ing to lock:
Jul 30 23:15:28 localhost 4,1264,95314282,c,caller=3DT0;ffffffffa5f763e8 (=
cpufreq_driver_lock){++++}-{3:3}, at: cpufreq_cpu_get+0x1c/0x70
Jul 30 23:15:28 localhost 4,1265,95314291,-,caller=3DT0;other info that mi=
ght help us debug this:
Jul 30 23:15:28 localhost 4,1266,95314291,-,caller=3DT0;context-{2: 2}
Jul 30 23:15:28 localhost 4,1267,95314292,-,caller=3DT0;2 locks held by sw=
apper/0/0:
Jul 30 23:15:28 localhost 4,1268,95314294,-,caller=3DT0; #0: ffff941800808=
958 (&p->pi_lock){-...}-{2:2}, at: try_to_wake_up+0x61/0x880
Jul 30 23:15:28 localhost 4,1269,95314301,-,caller=3DT0; #1: ffff941ade62b=
d58 (&rq->__lock){-...}-{2:2}, at: raw_spin_rq_lock_nested+0x23/0x80
Jul 30 23:15:28 localhost 4,1270,95314306,-,caller=3DT0;stack backtrace:
Jul 30 23:15:28 localhost 4,1271,95314308,-,caller=3DT0;CPU: 0 UID: 0 PID:=
 0 Comm: swapper/0 Not tainted 6.16.0-lockdep #861 PREEMPT_{RT,(full)}=20
Jul 30 23:15:28 localhost 4,1272,95314311,-,caller=3DT0;Hardware name: Mic=
ro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F =
11/11/2024
Jul 30 23:15:28 localhost 4,1273,95314312,-,caller=3DT0;Call Trace:
Jul 30 23:15:28 localhost 4,1274,95314314,-,caller=3DT0; <IRQ>
Jul 30 23:15:28 localhost 4,1275,95314315,-,caller=3DT0; dump_stack_lvl+0x=
5b/0x80
Jul 30 23:15:28 localhost 4,1276,95314320,-,caller=3DT0; __lock_acquire+0x=
f82/0x2620
Jul 30 23:15:28 localhost 4,1277,95314325,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 23:15:28 localhost 4,1278,95314327,-,caller=3DT0; ? __lock_acquire+=
0x48a/0x2620
Jul 30 23:15:28 localhost 4,1279,95314331,-,caller=3DT0; lock_acquire+0xca=
/0x2d0
Jul 30 23:15:28 localhost 4,1280,95314334,-,caller=3DT0; ? cpufreq_cpu_get=
+0x1c/0x70
Jul 30 23:15:28 localhost 4,1281,95314337,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 23:15:28 localhost 4,1282,95314341,-,caller=3DT0; rt_read_lock+0x56=
/0x2f0
Jul 30 23:15:28 localhost 4,1283,95314345,-,caller=3DT0; ? cpufreq_cpu_get=
+0x1c/0x70
Jul 30 23:15:28 localhost 4,1284,95314347,-,caller=3DT0; ? srso_alias_retu=
rn_thunk+0x5/0xfbef5
Jul 30 23:15:28 localhost 4,1285,95314350,-,caller=3DT0; cpufreq_cpu_get+0=
x1c/0x70
Jul 30 23:15:28 localhost 4,1286,95314352,-,caller=3DT0; amd_pstate_adjust=
_perf+0x1e/0x100
Jul 30 23:15:28 localhost 4,1287,95314354,-,caller=3DT0; ? sugov_get_util+=
0x34/0x90
Jul 30 23:15:28 localhost 4,1288,95314358,-,caller=3DT0; sugov_update_sing=
le_perf+0x102/0x180
Jul 30 23:15:28 localhost 4,1289,95314362,-,caller=3DT0; ? sugov_update_si=
ngle_freq+0x230/0x230
Jul 30 23:15:28 localhost 4,1290,95314365,-,caller=3DT0; update_load_avg+0=
x876/0x8c0
Jul 30 23:15:28 localhost 4,1291,95314369,-,caller=3DT0; enqueue_entity+0x=
31/0x390
Jul 30 23:15:28 localhost 4,1292,95314373,-,caller=3DT0; enqueue_task_fair=
+0x120/0x830
Jul 30 23:15:28 localhost 4,1293,95314378,-,caller=3DT0; enqueue_task+0x30=
/0x160
Jul 30 23:15:28 localhost 4,1294,95314381,-,caller=3DT0; ttwu_do_activate+=
0x9c/0x320
Jul 30 23:15:28 localhost 4,1295,95314387,-,caller=3DT0; try_to_wake_up+0x=
2b6/0x880
Jul 30 23:15:28 localhost 4,1296,95314393,-,caller=3DT0; __irq_exit_rcu+0x=
e4/0x140
Jul 30 23:15:28 localhost 4,1297,95314397,-,caller=3DT0; irq_exit_rcu+0x9/=
0x30
Jul 30 23:15:28 localhost 4,1298,95314400,-,caller=3DT0; sysvec_call_funct=
ion_single+0x8d/0xb0
Jul 30 23:15:28 localhost 4,1299,95314404,-,caller=3DT0; </IRQ>
Jul 30 23:15:28 localhost 4,1300,95314405,-,caller=3DT0; <TASK>
Jul 30 23:15:28 localhost 4,1301,95314407,-,caller=3DT0; asm_sysvec_call_f=
unction_single+0x1a/0x20
Jul 30 23:15:28 localhost 4,1302,95314410,-,caller=3DT0;RIP: 0010:cpuidle_=
enter_state+0x10a/0x530
Jul 30 23:15:28 localhost 4,1303,95314414,-,caller=3DT0;Code: 14 e5 00 48 =
0f a3 05 95 c5 8f 00 0f 82 b6 02 00 00 31 ff e8 98 0e 63 ff 45 84 ff 0f 85=
 9a 02 00 00 e8 4a aa 72 ff fb 45 85 f6 <0f> 88 e5 01 00 00 48 8b 04 24 49=
 63 ce 48 6b d1 68 49 29 c5 48 89
Jul 30 23:15:28 localhost 4,1304,95314416,-,caller=3DT0;RSP: 0018:ffffffff=
a5e03e20 EFLAGS: 00000202
Jul 30 23:15:28 localhost 4,1305,95314419,-,caller=3DT0;RAX: 000000000016d=
cc3 RBX: ffff941802124000 RCX: 0000000000000000
Jul 30 23:15:28 localhost 4,1306,95314421,-,caller=3DT0;RDX: 0000000000000=
000 RSI: ffffffffa5b5fdc6 RDI: ffffffffa5b4511d
Jul 30 23:15:28 localhost 4,1307,95314422,-,caller=3DT0;RBP: 0000000000000=
002 R08: 0000000000000001 R09: 0000000000000000
Jul 30 23:15:28 localhost 4,1308,95314424,-,caller=3DT0;R10: 0000000000000=
001 R11: 0000000000020000 R12: ffffffffa5f4c880
Jul 30 23:15:28 localhost 4,1309,95314425,-,caller=3DT0;R13: 00000016312c5=
53c R14: 0000000000000002 R15: 0000000000000000
Jul 30 23:15:28 localhost 4,1310,95314436,-,caller=3DT0; cpuidle_enter+0x2=
8/0x40
Jul 30 23:15:28 localhost 4,1311,95314440,-,caller=3DT0; do_idle+0x1d5/0x2=
60
Jul 30 23:15:28 localhost 4,1312,95314446,-,caller=3DT0; cpu_startup_entry=
+0x24/0x30
Jul 30 23:15:28 localhost 4,1313,95314450,-,caller=3DT0; rest_init+0x148/0=
x150
Jul 30 23:15:28 localhost 4,1314,95314453,-,caller=3DT0; start_kernel+0x92=
c/0x930
Jul 30 23:15:28 localhost 4,1315,95314462,-,caller=3DT0; x86_64_start_rese=
rvations+0x24/0x30
Jul 30 23:15:28 localhost 4,1316,95314465,-,caller=3DT0; x86_64_start_kern=
el+0xc6/0xd0
Jul 30 23:15:28 localhost 4,1317,95314468,-,caller=3DT0; common_startup_64=
+0x13e/0x148
Jul 30 23:15:28 localhost 4,1318,95314479,-,caller=3DT0; </TASK>

Log from 6.16.0 without PREEMPT_RT and with CONFIG_LOCKDEP (no crash occur=
s here):
[   27.272344] [   T2632] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid=
	 success!
[   27.272355] [   T2632] amd_pstate_ut: 2    amd_pstate_ut_check_enabled	=
 success!
[   27.272637] [   T2632] amd_pstate_ut: 3    amd_pstate_ut_check_perf	 su=
ccess!
[   27.272648] [   T2632] amd_pstate_ut: 4    amd_pstate_ut_check_freq	 su=
ccess!

[   27.280572] [    T943] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   27.280575] [    T943] [ BUG: Invalid wait context ]
[   27.280578] [    T943] 6.16.0-nortlockdep #862 Not tainted
[   27.280582] [    T943] -----------------------------
[   27.280584] [    T943] mt76-tx phy0/943 is trying to lock:
[   27.280587] [    T943] ffffffff9055a678 (cpufreq_driver_lock){....}-{3:=
3}, at: cpufreq_cpu_get+0x1e/0x80
[   27.280600] [    T943] other info that might help us debug this:
[   27.280602] [    T943] context-{5:5}
[   27.280605] [    T943] 1 lock held by mt76-tx phy0/943:
[   27.280608] [    T943]  #0: ffff8a245e66ac58 (&rq->__lock){-.-.}-{2:2},=
 at: raw_spin_rq_lock_nested+0x23/0x80
[   27.280619] [    T943] stack backtrace:
[   27.280622] [    T943] CPU: 1 UID: 0 PID: 943 Comm: mt76-tx phy0 Not ta=
inted 6.16.0-nortlockdep #862 PREEMPT(full)=20
[   27.280625] [    T943] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[   27.280626] [    T943] Call Trace:
[   27.280627] [    T943]  <TASK>
[   27.280629] [    T943]  dump_stack_lvl+0x5b/0x80
[   27.280633] [    T943]  __lock_acquire+0xf82/0x2620
[   27.280637] [    T943]  ? srso_alias_return_thunk+0x5/0xfbef5
[   27.280640] [    T943]  ? __lock_acquire+0x48a/0x2620
[   27.280643] [    T943]  lock_acquire+0xca/0x2d0
[   27.280646] [    T943]  ? cpufreq_cpu_get+0x1e/0x80
[   27.280651] [    T943]  _raw_read_lock_irqsave+0x74/0x90
[   27.280654] [    T943]  ? cpufreq_cpu_get+0x1e/0x80
[   27.280656] [    T943]  cpufreq_cpu_get+0x1e/0x80
[   27.280658] [    T943]  amd_pstate_adjust_perf+0x1e/0x100
[   27.280660] [    T943]  ? sugov_get_util+0x34/0x90
[   27.280663] [    T943]  sugov_update_single_perf+0x102/0x180
[   27.280667] [    T943]  ? sugov_update_single_freq+0x230/0x230
[   27.280669] [    T943]  dequeue_task_rt+0xf3/0x230
[   27.280674] [    T943]  ? mt76_wcid_alloc+0x70/0x70 [mt76]
[   27.280679] [    T943]  __schedule+0x1b8/0x1810
[   27.280683] [    T943]  ? srso_alias_return_thunk+0x5/0xfbef5
[   27.280685] [    T943]  ? schedule+0xeb/0x120
[   27.280687] [    T943]  ? srso_alias_return_thunk+0x5/0xfbef5
[   27.280689] [    T943]  ? lock_release+0x175/0x2b0
[   27.280692] [    T943]  ? mt76_wcid_alloc+0x70/0x70 [mt76]
[   27.280697] [    T943]  schedule+0x38/0x120
[   27.280699] [    T943]  __mt76_worker_fn+0x8b/0x90 [mt76]
[   27.280705] [    T943]  kthread+0x109/0x200
[   27.280708] [    T943]  ? kthreads_online_cpu+0x100/0x100
[   27.280710] [    T943]  ret_from_fork+0x25a/0x2c0
[   27.280713] [    T943]  ? __switch_to+0x11b/0x560
[   27.280715] [    T943]  ? kthreads_online_cpu+0x100/0x100
[   27.280718] [    T943]  ret_from_fork_asm+0x11/0x20
[   27.280724] [    T943]  </TASK>
[   28.461993] [   T2632] amd_pstate_ut: 5    amd_pstate_ut_check_driver	 =
success!


The crash also occurs in versions 6.{13,14,15} when compiled with PREEMPT_=
RT

Bert Karwatzki

