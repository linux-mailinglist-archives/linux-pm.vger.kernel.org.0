Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA5670AFE8
	for <lists+linux-pm@lfdr.de>; Sun, 21 May 2023 21:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjEUT0g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 May 2023 15:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjEUT0f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 May 2023 15:26:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2095.outbound.protection.outlook.com [40.92.18.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C95DD
        for <linux-pm@vger.kernel.org>; Sun, 21 May 2023 12:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE80Mwe/mXRyt4RhgOgGf256zzFigenGzCy0vzGqq07sh0Xs9jpve0dFPogpsbe8G9LNDqL5/4/LPwj9Znx/CiBjIPWXjLW//oiIvjinBTidNB93uodZUYOXL9PXglB8+ZzmjKa+Uk9NEiuVtpjbqQf9IRzIJ2DwQw0vVrDCi8iNKYEWer5J9jgOPpuMNhB4EfVa+lxypFtLUwXtyNwjq3SexKQ0bGdAAaBwo4bsqzz0Mocv6FaswI45FS1pW8vWGijONKUr6nthGf0RaEWOt2XtTP88JilSrC/gudaySIKARfhWljLBpLuWb90JKdBXQUzRhwKtl/+MHLKUPY+axg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV3g+e9Svi4s58X2yYee1jM2oB/CLPR8iInVKJ/SX1s=;
 b=MkKLx0Hi0O9tDCsidzgSAUQ440eVgJdFvS+sgqH5+X1d4EjZrOikc/9HWKTWpk5oesx57YKxcVThEzQV+gWvPhdWorwlvtqWB355hZJlB35DjjG9QQym7PCmlhFDzna0D5Hwaj59E+wHzL8/7ckBIbBMdnYAXJfW+whCduLnLeHziYHJeNrWvyFvCBxNqYrDim8oIq/uvUA4qnzC0R7/bKFJuHmu/Y9+3antHw5OmMyU006Z3VGwCEwXFCzTeAUY2UlK1cWc7gRb3+pjC85kc5ozMef72h1jzlR9FppbsuFy5QyDWMgzr2QKf46sG2tOoZ8DMoG1qt3kWCRC6gmMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV3g+e9Svi4s58X2yYee1jM2oB/CLPR8iInVKJ/SX1s=;
 b=VAoFI60mo4jQbCi+c5iwBtTZsS19TdEzbHwUn2J224fhSXlrxXSGA2CY1DxRVHaMhPqOPNis2Sm4bR9mOmokQBJ23URW/snrlP0f8pGnitIKeq0xr0KYiOcUSRvXmuPjnLjzxrcoPQwtJrxqdFe+JewhLzHBYiYM7ANWIjN/PVIMznQHh7+XRRv5NbmlCPR4qrAGuQQ4iPIPmLqdm03zXkE4Fu/3ZfNKoaR0RQl9hnOkzGFaSfiimFWc6xhsB5abe3KbAmFrugiJhOmPh3XaDGDPsC5iNqA0wq1Iy6eLv73BIehIlpt3g1RB7bkII8OqcZXpaSi3t3SMLKpWNXVWMA==
Received: from DM6PR19MB2780.namprd19.prod.outlook.com (2603:10b6:5:13d::26)
 by CH3PR19MB7659.namprd19.prod.outlook.com (2603:10b6:610:125::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.13; Sun, 21 May
 2023 19:26:30 +0000
Received: from DM6PR19MB2780.namprd19.prod.outlook.com
 ([fe80::c62c:7fe7:679d:6a42]) by DM6PR19MB2780.namprd19.prod.outlook.com
 ([fe80::c62c:7fe7:679d:6a42%4]) with mapi id 15.20.6433.012; Sun, 21 May 2023
 19:26:30 +0000
Message-ID: <DM6PR19MB2780634FE9D96D6FB72712B2BC429@DM6PR19MB2780.namprd19.prod.outlook.com>
Date:   Mon, 22 May 2023 02:26:23 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     linux-pm@vger.kernel.org
From:   Ratchanan Srirattanamet <peathot@hotmail.com>
Subject: ACPI: what should Linux do for "call-order-swap" quirk from firmware?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [NiLSKQE/ppPViLxMSRzacRJY3LsUgNWS]
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To DM6PR19MB2780.namprd19.prod.outlook.com (2603:10b6:5:13d::26)
X-Microsoft-Original-Message-ID: <80caddda-8b5e-f8ee-6cb3-821f5e0fc16b@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR19MB2780:EE_|CH3PR19MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfcbc30-1a64-45bf-d81a-08db5a3146dc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2Wt7d8hoylpWSAeeTwjsmK2dSNo2D6cVuVhS0jEXM1H++OCcc81xWbSD+D1XJJF/7p349LBIGvUWThW+YNQyn0GY0y0Cea0Hq4kT/dtPMyviQtqDeRH7NrcT84//k2CGPkDZWYMAYtYsy1FhYly3OgZS+qacc/Nvqgn7GUggeDHpctMZ5i2+yfyQ+pO8S+lkE7/OZVJ3jVbABhn7Tqq0bbsV1TotFiK6+OWo0QcMk+oYNtKdhccKgLcr955AV05zDwuaFg5Fi11raOTJ5Kl4UrNKjvfTfpsz9u3QrjIl1R43vH4GFtAr/yALAReiTcCfbDrblbCn5EGSN/edtFu2Zn9/MS2bywVzxibD0KBKvSGlD4VHC+rDuGaQAFvAnukgHD05vI6kGAl4xBtV7MP74+IQpn8h++aGEcffB7Vx56/1w+3s2NuMd3u3DuIdrA1f5wX0uuJeemrcDYmV3hrPfjsGxZJZjZiXJeQ/qIUNtoroF/Mxt30d/O003etiF5mfhZyKqZjNj486/1HH1TIhb4kiOwcvSywlduQBB7K8dg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0l4N1RiWTNHRTNaWmtDcjZnNUVlZjVUSCtaaktVYXYyOFBiOWh3Rit4cTRv?=
 =?utf-8?B?SmJMdHRCdEdvcjVpOFFybjlERVNTQzlKTjR5c2tpb1lyNWtURnpGMnhoMGI4?=
 =?utf-8?B?TU9hckRpVXNPRVN2MEliYmt1ZHRadmlGeXVpdW1GV1JRaW84dHA2TW5GQTR5?=
 =?utf-8?B?YWNaUGgraFZBOUZ2Z3NxMmY1Y1JQQUFvMEo5b3BrbklMTlBZazlGTGEyY0dT?=
 =?utf-8?B?WnhQUEpVeXc1QkNLZS9zdW4vYnhJS3lDVXZEaHI0RkpxNEtob1YxUnNjYTh5?=
 =?utf-8?B?VDRMY3VUSDFXdGs3ejc1bFMxWGUydm9EVGtLZWlpUlBoNlJDWFdDS24xRHZF?=
 =?utf-8?B?UkZuUThIbWRLUldZdTY4K3JXRlliZVlIcnk2TVROSWJuQWIwYWdtTmVTMU1n?=
 =?utf-8?B?YjBYd2t0Vmd5alh4d1dYMnVaYmRXclVpZXBlN3cyb01ZdHpBTGRzMUxqckR5?=
 =?utf-8?B?S2FRa0d1NFljb0wvMmI0YkY3a0ovNUpVTjBBaER5RG1xU3BEZWNUYktnbUNi?=
 =?utf-8?B?NVJZZUxkV1NJa2VjczVXSFVxNGdnZzM0enpGeVhkV3IxTWlTVU5hNTUxWDJT?=
 =?utf-8?B?Zld2NEtZTFR5SjVIcXhVOVNlTEEwKzRNaFdOeSs0bTc2SkVWUlZMUHpJa1JP?=
 =?utf-8?B?MVAxMTRUNE5TdDBseFEwZXZRYThvQWhPU01YZHV5cStxSnd0QzJnakhocjFB?=
 =?utf-8?B?a2hGUVg0NFdkcjcvVmx1QlM2QnZHcGc0SE9oN3F2NFRXMkRORWdlZDgwNmQ5?=
 =?utf-8?B?WG51TUpQNndmUm5qSXlDWEE2ekk5NmFkQWZ2UVM1WnlWZDdnTHMyMEtZKzBG?=
 =?utf-8?B?eTdtdWZ1eXdwSFdENXNnc2JuQkZiKzB2S1hxT0NSNU9pVnMva2Q5YnlONU1K?=
 =?utf-8?B?VXAvZ0hZczRPWnBzcDlnTWExd29aOTdnbDZ3Z2tYRENSWWZhclYzeE8zb1Fu?=
 =?utf-8?B?Z2VTbzBkYVRlV25Mem1IWFNJNmtlSFFnVS9SMUlzelAxdkFJalRnZ1hXdVRX?=
 =?utf-8?B?UnNUa0k4dE9aUDJxTVFaT0Z2OVlDWUd2RW9Ndm55aE9EenROSUpuWmlVaWtq?=
 =?utf-8?B?b2pLOEJZak5hcnhDbnpCa0VhazYrQTJDTktjbnZPQnEvSVNlRVZLVXF4T1Mv?=
 =?utf-8?B?eHZnMVlUa3BPKzRQT0tobEtneTRYNjVjNHFZc1JOeERRV0pyMXZkajFoZlNl?=
 =?utf-8?B?aHo5RUhWTEZXY091MXppdW42UHNoS2U0NjNPc0FZNXlQM3ZjMC9iZFdGczFu?=
 =?utf-8?B?cUVodWtsVTBMK2xoSzRhdTJzeEVJWWlIREFhMUJUVjF1TTFtSDVLdTJxdTFl?=
 =?utf-8?B?RTc2NkEyODk5Q1F5OU81VE1qa3RzbEZkVmpTWjhxMkxsU0x5MzRsSG5XeEZ3?=
 =?utf-8?B?YkJBbGI4NFQweG1CNzRvRnphWENaaGNaUHpzQmdBazJXVkxBck0vZTZUVkdz?=
 =?utf-8?B?dGh2TDVXRmJJUjFTNUNWZTMvK042NFpqeWFBdGFsSVRBWFUrS0Z5ZGg0NWNz?=
 =?utf-8?B?TVVKUEk4NkpHZmVzZlBtZnlHaXFHTkMxN2gySmpBVkFROHdIQStKT1lORnlz?=
 =?utf-8?B?UDJHSFZXNHZwZm9WSUZUeUVYV04zWDIrZHNFWGJvRGk0UVpOaThvd2hHbHV3?=
 =?utf-8?B?Nnd1RlZ6My9KR1NjK294TkFuQnlDVWc9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e7757.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfcbc30-1a64-45bf-d81a-08db5a3146dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2780.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 19:26:30.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7659
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

I'm trying to debug an issue where Nouveau is unable to runtime-resume 
an Nvidia GTX 1650 Ti in an AMD-based laptop [1]. As part of this, I've 
traced ACPI calls for the same device on Windows. And it seems like this 
device has a weird quirk, which I call it "call-order-swap" for a lack 
of better words, when it transitions from D3cold to D0.

So, a bit of context: Lenovo Legion 5-15ARH05 [2] is a laptop sporting 
AMD Ryzen 7 4800H with Radeon Graphics + Nvidia GTX 1650 Ti. This 
device's PCI-E topology to the GPU is:

00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir 
PCIe GPP Bridge [1022:1633]
         +- 01:00.0 VGA compatible controller [0300]: NVIDIA Corporation 
TU117M [GeForce GTX 1650 Ti Mobile] [10de:1f95] (rev a1)

And for ACPI perspective (according to my interpretation), a power 
resource \_SB.PCI0.GPP0 seems to represent the PCI bridge, having 
\_SB.PCI0.GPP0.PG00 as a power resource, and \_SB.PCI0.GPP0.PEGP seems 
to represent the GPU itself, which doesn't seem to have its own power 
resource. All ACPI table dumps and infos can be found in the issue on 
Freedesktop GitLab [1].

Now, if I understand the specs correctly, when transitioning the GPU & 
the bridge back from D3cold to D0, the kernel should start up the bridge 
before the GPU itself. From the ACPI perspective, I should see calls for 
.PG00._ON() (power resource for the bridge) before .PEGP.PS0().

However, on Windows [3], instead it seems like .PEGP.PS0() is called 
before .PG00._ON(), for some reason. This is weird, because if 
.PG00._ON() has not been called yet, .PEGP.PS0() should be even valid to 
call. Now, I have no idea on what part of the Windows system is supposed 
to call those ACPI functions, but my feeling is that it must be either 
Nvidia or AMD driver that does this kind of quirks.

As for what Linux does... well it seems like when Linux resumes the PCI 
bridge, it calls only .PG00._ON(), skipping .PEGP.PS0() on the ground 
that the downstream devices must have been reset when that happens. I'm 
not sure that's the right thing to happen either, but at least it makes 
more sense. Nvidia's proprietary driver seems to disable runtime D3 
support inside it completely on this device, so I think Nvidia must have 
a quirk for this chipset, as I briefly borrowed my friend's laptop 
sporting AMD 6000 series CPU and it doesn't disable runtime D3.

So... I'm not sure what the correct behavior is here. I'm a developer 
myself, but kernel is not where I'm familiar with. Please advise me on 
where I should look next.

Ratchanan.

P.S. please make sure to include me in the reply, as I'm not the list's 
subscriber.

[1] https://gitlab.freedesktop.org/drm/nouveau/-/issues/79
[2] 
https://pcsupport.lenovo.com/th/en/products/laptops-and-netbooks/legion-series/legion-5-15arh05/82b5/82b500fqta
[3] 
https://gitlab.freedesktop.org/drm/nouveau/uploads/2659e5cb41a52290ebf18d9906408d62/nvamli1-processed.txt
