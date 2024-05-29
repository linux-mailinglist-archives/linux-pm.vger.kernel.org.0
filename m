Return-Path: <linux-pm+bounces-8397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB63E8D4026
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 23:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68D71C21DCB
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3641C8FCA;
	Wed, 29 May 2024 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="X8/G77T1"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic313-21.consmr.mail.ir2.yahoo.com (sonic313-21.consmr.mail.ir2.yahoo.com [77.238.179.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD3F1C8FCB
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717017202; cv=none; b=QTHH0vLjLniJ7MgEyJYHxcHx4D5YcT+eVCxTIhZWtEPbOEfPqI/paFleWebkctXm76tfsgZG0LgTOME8lRBGvX/ZxCO/Esh9sjkwxfaehI2nV3pJn1PjbE7z6s4fNEXbg/n48tpM5AbF/mhnSIbRYdTjJrWZMSIU/rZ9zegw9jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717017202; c=relaxed/simple;
	bh=6I1lr2IiXHOM4eptex4oTkgRXSn6rLEKl0TWjIa8O/Q=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:References:From:
	 To:In-Reply-To; b=l6u39LpdoEdI7yQJKz1gPN/jOMK/O3fDL44KGyMjX+TA0zVnHGrXWZNgPVc/FT2TRzuQE9R6cmy1WstimMA4L31UiwyXiYXqYYIXMoM2m2dQBvSbYN63rRePGnJX2Cq9n/03lRI+3wscdG7ifJr/sfukxAXdpNCDXta2Yk1nzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=X8/G77T1; arc=none smtp.client-ip=77.238.179.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1717017198; bh=Bi6dFjMMRx4Ezxm7N/HSWfYvCtIzmtJgqCtL5sKJnzE=; h=Date:Subject:References:From:To:In-Reply-To:From:Subject:Reply-To; b=X8/G77T1EQ+DyAaBeudgfbAoPvrSo9nmc7Vp2iwXoeDamBTNAmY0nYmtvi+s6BgSBUVcKCJj7U+/d7RkDjEmMsvUW5DUT1+AlcubmnDKZOU3y+yMTbc3V2yOYd82caPNOKcM4war7apqCcYjEgP42cvuSZOSLy0VCGBMRiHGIlwC50aH8gU7foVmebAIFCCmkC/R2dlGK87dDaE3tJw5HM/T+VZdXt2KSZchoqGK+W0R/ZmKzQWXxw2BtUikTVcYLpQwQWGCKs0nzkcSeUmMIootzH0InnQ4ntkPENgTYSf5O10on7KsXgo0f2HoOKIQh2xWAaOHWLEQv07ULwgBgQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717017198; bh=gYVudnQsy202ciYcZt+lQNJbZfyaIKAc4uXAHKz1FKP=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=f4NqnkyFWGLDIX0mjqALDHIm8YjbPJS+DD/pKoed3a5XD+qJmd4mdnftaIDqXFGAQL/AQ3N7yOdYsnvNh/VsmFQt4jNTj64bvwkBjVINfGX0Ew3Pyoa6nNv3vRW7ZQAdVnz6/w/x6wZvj/R5SlveLHJjUNDqbW7XbKILc0Enn/eVH32o+uq3kGRWL+USiWYlojrr9j3+oxVkZilPol5F+aMqthoTfat1OHpuaQFcjtFK3lDnUlZGKLp8ubfYqjf7ALKrAVuF4fuhIJe9S8QgMEODkPhVEVVREmiaOoEeaoDQ9Jz19OtG/ncvaxCW7vwkHwuzLO5K73A+ic8JNUKARg==
X-YMail-OSG: md4W8QsVM1lzi0wl4AQ0pj9MnCcFPsgbvQKWJvPHoP2XTsmXcwJGm16APiTKXN9
 QuPqJMt93d8A_E_j_yY0msT_H591cRN3EOMe.d11gklsHUwX1UxpRllivj2u_YfI5VZqxZWlDkYK
 5rbR0S_moQHCZb7bhpb0M5mcNXOV0LiobtQ9.m.eBpyWOp4fubuF1qfGrjF42zGJeU3yEwBtk7b.
 Sx9zXSiTO_e3jcwkVyUOYwkETKD2BdEb1dCfJwBmqyzAAN3ag5kM9AhlRiwhephLWtH_Mox8GCJd
 lSM_H6W4lOUzrI9hMZgxrZosldhlIE0iRTjDWG3rYlSKx4l0zQM36u5gxe6xPgsY9dgBFN05K95G
 ez.R7zc5VFplMEEI_vJQewo3s2tS0844s3LTXMvJVwXr9qrkItfQaVkYLU6a2Fgzs5Qm8v0oMJAR
 qUxxfrrSacXQxtpuFrtT3.HRVVe2UcXtw3Q_BR_te6W5aDKJAFe22dnN8MwyMLZe2cJxNjq44NAW
 JbCdjM6oygnOBYbutwdZI..mrVKnnPXUxRgqD0UFUo9CZQ.ADzzBXYD3KMdOmzXfWHAXpFA_pde0
 qNdusbY6FXgTaCFsaUQ3NW8.bBtrz33ePv8VL4JWKdlxpk.gXteyDkIBEq6fTFpQ09nwVPBAZaur
 AyiRjScgdBF.6IFNIb4Gi97UAxVPbrtkbQGUlbBqmmCedFUMrGe6tGsA1UgjnMFwec7EyCrri2bA
 GM33RSZ67hKxcsTRwxR6eBb_6uGEl5Tj61QN472zKrxemsYOXPuoUESGJhKqSP2_kIbt0gnE_yEP
 38HKuxePvKd2vJfSR.cnGpKXr1l08Arn2QIW0NsdgcGI42TLxhIA_jKTTAwVSIvwHSw6lmPnbnXZ
 72TAyFSbJp1QDkeTXRRqQL.sN2BczonhJgQIEmXpQL4IlrKpDIk3cxiiiusgRJ_HQGu.Cax1Uj0v
 TUsQEWMryQtnOwRDY6H7lDKLxnsibp7Aws.3QCtf4sUw8enDprGS9wQ2Jdzh23vi0fVBDPdlH70N
 rGLQJLlFhoLcJtLnPBS7pR5DGGbI.YJgjxm6iPBw.3tRYkSl1EVlUzwvz9q6Nqt12Sm6Qm42j1y5
 namQ4U4_1BEIqr6daWD3JL0nRoLaINsdkIVEU.mSgRMGkf6iSk6h6phMVYRtoveYfMFqBEhFX_ai
 Shf31THa.EHTTxNWs..bLfGNiLsY_.KqV12Kl3Pel6RANvU_ITlfKVc16sHSnX4IemrFySXPC_BL
 kD7NcOtbhuSNPDHORLEsD9neU_Tb9Qc.PkjkpnTdEmtkonZkYtYB9go8Gi3Ysgr2JM9jne50PoL1
 AWfubd__8IogEXrVIjsmNUxMidMAxvfqPpxja_xZWg75ZgpBVI.B2VZuEhQNFu87bMprN_BBFFO5
 2gzXlRySbzqXrw65_U.TtT33u3qszMrC6jzqbmkLDNE4pWTLDeudINrwq7nYVrYAx0TJp_aGmDG7
 h2YQl7XUKofFAItBMdXQbLwo_3R3SB4GZTPCZQ.pgL0HOPqP1zfwIKrjrjHRkKkdpPIutbxUcVOA
 4OgwpEqwprGMGWO9OAmYyDYbknYjs5apMmrkubo5bZRoBIQgP7Lv4rJjKa7ocGa11XOJeP4yB8C0
 GFyOxmMs9kLhbkolEBwvdkaqzKoX8UUrXRSb0EttXfjXJpsZOHTXtFV96eQ8kTlsCKEI6R636JFY
 q84h0dQZLr3Fy4m82_0sLu3qXYgEgi.wtf0v7kQ8siMHzMQO9yKAk56PbSyzRkOMYnD4PnD2iJO8
 GLojwQII3hYSgXDA_jtadNpROqJfURvX6X2Mgkc7u3qZmWfalqHziD.x1oYu51ixkr85hmvVO2Ss
 11Om.SWxKwsuRGVhsEuUN35uO04lC3zT5.kHbDxFSlmBn2LViXLve3C5RPuzj9uq71nu.Gl70qoV
 w4UhJHjRWTBbnBpOMCGXz2r7EFRs7kV1PpIpsuA2VTVHmXb8TLdRATgZg9CU.wctvgjkfG4NQ04o
 P0zb8Mirz9aa_cU7ynN0q0po2B6MBskp2JODiPdah9FgVW69YXqPSLgeUL5sAYd9Fbmo9cDTjWcB
 oB3FgtXRdClHw7WT5c.TIveQUj.03_mZR2DFy4eE5XJcBiVz2Kf3UKkkN5OK4FmGRxyXBVLXv8Wh
 I9xQMA8j2HxwP9DqfwW8Ix_0jxD5yneUK2a0u_OdldR3dFdRPkkhQX5dNybTvn3poUF76ZtpA4wh
 iuucuaBL.DswWRPWH1XE9btThMWcVf7P2IMYFcRbfLLo-
X-Sonic-MF: <fhortner@yahoo.de>
X-Sonic-ID: 364d35fa-43a0-4063-8739-9091708067f4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Wed, 29 May 2024 21:13:18 +0000
Received: by hermes--production-ir2-7b99fc9bb6-vmqpt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 181bfba561789aa3ec7a480bf0c72ecc;
          Wed, 29 May 2024 19:52:12 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------7SY0qyf16Icg0fPMSXCbfF2G"
Message-ID: <7f4a777b-88f6-4429-b168-d1337d291386@yahoo.de>
Date: Wed, 29 May 2024 21:52:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Bug Report according to thermal_core.c
Content-Language: en-US
References: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
From: "fhortner@yahoo.de" <fhortner@yahoo.de>
To: linux-pm@vger.kernel.org
In-Reply-To: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
X-Forwarded-Message-Id: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
X-Mailer: WebService/1.1.22356 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This is a multi-part message in MIME format.
--------------7SY0qyf16Icg0fPMSXCbfF2G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

After bisection I have reported a bug according to thermal_core.c:
After "Resume thermal zones asynchronously" commit: Wrong Battery 
Reading after Wake from S3 Sleep - Lenovo Thinkpad P1 Gen2

https://bugzilla.kernel.org/show_bug.cgi?id=218881
Could you please have a look at it

I have performed a bisection and the culprit is this commit: Resume 
thermal zones asynchronously
git bisect bad 5a5efdaffda5d23717d9117cf36cda9eafcf2fae
# first bad commit: [5a5efdaffda5d23717d9117cf36cda9eafcf2fae] thermal: 
core: Resume thermal zones asynchronously

I have also verified it by compiling a kernel without this commit.
--------------7SY0qyf16Icg0fPMSXCbfF2G
Content-Type: text/plain; charset=UTF-8; name="bisection-log"
Content-Disposition: attachment; filename="bisection-log"
Content-Transfer-Encoding: base64

Z2l0IGJpc2VjdCBzdGFydAojIFN0YXR1czogd2FydGUgYXVmIGd1dGVuIHVuZCBzY2hsZWNo
dGVuIENvbW1pdAojIGdvb2Q6IFswZGQzZWUzMTEyNTUwOGNkNjdmN2U3MTcyMjQ3ZjA1Yjdm
ZDE3NTNhXSBMaW51eCA2LjcKZ2l0IGJpc2VjdCBnb29kIDBkZDNlZTMxMTI1NTA4Y2Q2N2Y3
ZTcxNzIyNDdmMDViN2ZkMTc1M2EKIyBTdGF0dXM6IHdhcnRlIGF1ZiBzY2hsZWNodGVuIENv
bW1pdCwgMSBndXRlciBDb21taXQgYmVrYW5udAojIGJhZDogW2U4Zjg5N2Y0YWZlZjAwMzFm
ZTYxOGE4ZTk0MTI3YTA5MzQ4OTZhYmFdIExpbnV4IDYuOApnaXQgYmlzZWN0IGJhZCBlOGY4
OTdmNGFmZWYwMDMxZmU2MThhOGU5NDEyN2EwOTM0ODk2YWJhCiMgYmFkOiBbY2Y2NTU5OGQ1
OTA5YWNmNWU3YjdkYzllMjE3ODZlMzg2MzU2YmM4MV0gTWVyZ2UgdGFnICdkcm0tbmV4dC0y
MDI0LTAxLTEwJyBvZiBnaXQ6Ly9hbm9uZ2l0LmZyZWVkZXNrdG9wLm9yZy9kcm0vZHJtCmdp
dCBiaXNlY3QgYmFkIGNmNjU1OThkNTkwOWFjZjVlN2I3ZGM5ZTIxNzg2ZTM4NjM1NmJjODEK
IyBiYWQ6IFszZTdhZWI3OGFiMDFjMmMyZjBlMWY3ODRlNWRkZWM4OGZjZDNkMTA2XSBNZXJn
ZSB0YWcgJ25ldC1uZXh0LTYuOCcgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L25ldGRldi9uZXQtbmV4dApnaXQgYmlzZWN0IGJhZCAzZTdhZWI3
OGFiMDFjMmMyZjBlMWY3ODRlNWRkZWM4OGZjZDNkMTA2CiMgYmFkOiBbMGNiNTUyYWE5Nzg0
M2YyNDU0OWNlODA4ODgzNDk0MTM4NDcxYzE2Yl0gTWVyZ2UgdGFnICd2Ni44LXAxJyBvZiBn
aXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaGVyYmVydC9j
cnlwdG8tMi42CmdpdCBiaXNlY3QgYmFkIDBjYjU1MmFhOTc4NDNmMjQ1NDljZTgwODg4MzQ5
NDEzODQ3MWMxNmIKIyBnb29kOiBbOWY5MzEwYmY4NzM0OGUzNmE5OGZmYTA5YzRlMjg1OTA4
YzE0ZjU5Ml0gTWVyZ2UgdGFnICdzZWxpbnV4LXByLTIwMjQwMTA1JyBvZiBnaXQ6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcGNtb29yZS9zZWxpbnV4Cmdp
dCBiaXNlY3QgZ29vZCA5ZjkzMTBiZjg3MzQ4ZTM2YTk4ZmZhMDljNGUyODU5MDhjMTRmNTky
CiMgYmFkOiBbMzI3MjBhY2E5MDBiMjI2NjUzYzg0M2JiNGUwNmI4MTI1MzEyZjIxNF0gTWVy
Z2UgdGFnICdmc25vdGlmeV9mb3JfdjYuOC1yYzEnIG9mIGdpdDovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9qYWNrL2xpbnV4LWZzCmdpdCBiaXNlY3QgYmFk
IDMyNzIwYWNhOTAwYjIyNjY1M2M4NDNiYjRlMDZiODEyNTMxMmYyMTQKIyBnb29kOiBbYmQw
MTJmM2E1YjAyODQ5ZDlhY2M4NWUyYjhiNzEyOTNjZTA3MjI2M10gTWVyZ2UgdGFnICdhY3Bp
LTYuOC1yYzEnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9yYWZhZWwvbGludXgtcG0KZ2l0IGJpc2VjdCBnb29kIGJkMDEyZjNhNWIwMjg0OWQ5
YWNjODVlMmI4YjcxMjkzY2UwNzIyNjMKIyBiYWQ6IFtiOWI1NmViMjgwNDUxY2NmZDQyZTll
NTU0ZTgzYzYyMDJhMmQyODZiXSBNZXJnZSB0YWcgJ3RhZy1jaHJvbWUtcGxhdGZvcm0tZmly
bXdhcmUtZm9yLXY2LjgnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9jaHJvbWUtcGxhdGZvcm0vbGludXgKZ2l0IGJpc2VjdCBiYWQgYjliNTZl
YjI4MDQ1MWNjZmQ0MmU5ZTU1NGU4M2M2MjAyYTJkMjg2YgojIGJhZDogW2Q2NTQzNjJkNTNh
ODNlZjNiOTIxZjNkMDY4MTJlMTIyOTA2NDZhOTBdIE1lcmdlIHRhZyAndGhlcm1hbC12Ni44
LXJjMScgb2Ygc3NoOi8vZ2l0b2xpdGUua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdGhlcm1hbC9saW51eCBpbnRvIHRoZXJtYWwKZ2l0IGJpc2VjdCBiYWQgZDY1NDM2
MmQ1M2E4M2VmM2I5MjFmM2QwNjgxMmUxMjI5MDY0NmE5MAojIGJhZDogWzNkODI3MzE3YjE3
ZmViYmEwMmI2Yjk3NmZhOTEwMzY0MjIxZmVjYWZdIHRoZXJtYWw6IGdvdl9wb3dlcl9hbGxv
Y2F0b3I6IFJlZmFjdG9yIGNoZWNrcyBpbiBkaXZ2eV91cF9wb3dlcigpCmdpdCBiaXNlY3Qg
YmFkIDNkODI3MzE3YjE3ZmViYmEwMmI2Yjk3NmZhOTEwMzY0MjIxZmVjYWYKIyBnb29kOiBb
YjY1MTVhODhiYWY0NjI4ZTkzZmNjMzljMmI4MWZjMTc0MGViM2MzZl0gdGhlcm1hbDogdHJp
cDogRHJvcCByZWR1bmRhbnQgX190aGVybWFsX3pvbmVfZ2V0X3RyaXAoKSBoZWFkZXIKZ2l0
IGJpc2VjdCBnb29kIGI2NTE1YTg4YmFmNDYyOGU5M2ZjYzM5YzJiODFmYzE3NDBlYjNjM2YK
IyBnb29kOiBbNWY3MDQxM2E4NTA1NmRiMDQwNTA2MDRhNzZiNTJlM2YzOWEzN2YyMV0gdGhl
cm1hbDogY3B1aWRsZV9jb29saW5nOiBmaXgga2VybmVsLWRvYyB3YXJuaW5nIGFuZCBhIHNw
ZWxsbwpnaXQgYmlzZWN0IGdvb2QgNWY3MDQxM2E4NTA1NmRiMDQwNTA2MDRhNzZiNTJlM2Yz
OWEzN2YyMQojIGJhZDogWzVlYjRmNDEzYWQ2MGRiN2M0YjExYzRkMzMxYjA0ZjI5MDljOGJh
MTRdIHRoZXJtYWw6IG5ldGxpbms6IEFkZCBlbnVtIGZvciBtdXRsaWNhc3QgZ3JvdXBzIGlu
ZGV4ZXMKZ2l0IGJpc2VjdCBiYWQgNWViNGY0MTNhZDYwZGI3YzRiMTFjNGQzMzFiMDRmMjkw
OWM4YmExNAojIGdvb2Q6IFszM2ZjYjU5NWRjMTQ2Nzg3MTcyNzRjMjcwZDAyYzdkN2UwYTNj
NDA0XSB0aGVybWFsOiBjb3JlOiBJbml0aWFsaXplIHBvbGxfcXVldWUgaW4gdGhlcm1hbF96
b25lX2RldmljZV9pbml0KCkKZ2l0IGJpc2VjdCBnb29kIDMzZmNiNTk1ZGMxNDY3ODcxNzI3
NGMyNzBkMDJjN2Q3ZTBhM2M0MDQKIyBiYWQ6IFs1YTVlZmRhZmZkYTVkMjM3MTdkOTExN2Nm
MzZjZGE5ZWFmY2YyZmFlXSB0aGVybWFsOiBjb3JlOiBSZXN1bWUgdGhlcm1hbCB6b25lcyBh
c3luY2hyb25vdXNseQpnaXQgYmlzZWN0IGJhZCA1YTVlZmRhZmZkYTVkMjM3MTdkOTExN2Nm
MzZjZGE5ZWFmY2YyZmFlCiMgZmlyc3QgYmFkIGNvbW1pdDogWzVhNWVmZGFmZmRhNWQyMzcx
N2Q5MTE3Y2YzNmNkYTllYWZjZjJmYWVdIHRoZXJtYWw6IGNvcmU6IFJlc3VtZSB0aGVybWFs
IHpvbmVzIGFzeW5jaHJvbm91c2x5Cg==

--------------7SY0qyf16Icg0fPMSXCbfF2G--

