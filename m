Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F082762FD
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 23:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIWVUX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 17:20:23 -0400
Received: from mail-eopbgr670051.outbound.protection.outlook.com ([40.107.67.51]:9040
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbgIWVUX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Sep 2020 17:20:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfCVy4dmx/9qsELszYqJzRThHo3djuGvqmGteddKSenWXd8MWERYjbPOXyZ5SL2A+mqhu5Y5wJjsfSdideFt+WZ/WfUH8YbEr1ClPG27kkfjgiJYb2imZiinvjI44zWx4lG0uazeq5sAc0OGPr9atoZWY6psa/pa+YbaqU4hPNnQvalpi0sAx8xuwAgo47ApSoBceBbwQkHft57ShLjx6iTSTmCyTD3UaloYODISOHHdc9fwD9gFcVXp4lROVOC+NHoG2uiFJoOzToH+YwIgxyi3spS8BN6urrBRdrIm3FlYqvy8Qz/wdbSxb5i8/2DZ7C89gIXsV8izOeHSQMBfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJPnbUtu+RpgiUXMowQN1sU8q+Co6nnzDgAHeyfHYhA=;
 b=XmgBqV53QbE/ADWKLlTvcVxTNl6FqZLvOUfMcQBxj2rbG4LrPcsGpflqcx2i3JG5c3quZH1aY+xZpx1sFeefQ+ZGYElnXcCmBt/HCFqGSbsMwdi0/QJqxf/A09mUECm53SMz3JeOAI+DM+PiQd34aAhnCYkeYM3+wCxKv6ZkpchzNicuAnGez+oSNEybA8Dmnfm62Ii85s15ghtJu06MThBSfCgn7UXj+wY0fW4Zqi6/gAeEB931uwS0H6FSd0FRmRlUB8vBOetgvqJ1G1J0L5xQ9DHlE1QXD2cVqSfoc+brwwcYIzPu9/UfsZA6TLvrwBMNVRYXQfi1LP/lJudkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJPnbUtu+RpgiUXMowQN1sU8q+Co6nnzDgAHeyfHYhA=;
 b=fC52KGlOK8pM9GpAWEsH/kDWLOBcYxz9HOprFuQGQwpFH7M3BDLykeJO5KutBQAoPFI3sVtR/+8BIjr5CpNbQawfbeX8n6P/4ruzszJoINBk/JgyzwZqLmghdBzjIC4D+XrDm81nisIODeYs+odzByc31XrdNSFzBI/7rtETCl8=
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f::20)
 by YTBPR01MB2607.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:1b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Wed, 23 Sep
 2020 21:20:20 +0000
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5c60:6462:fef4:793]) by YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5c60:6462:fef4:793%3]) with mapi id 15.20.3391.026; Wed, 23 Sep 2020
 21:20:20 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: WARNING in clk_core_disable and clk_core_unprepare with imx6q-cpufreq
 and schedutil governor
Thread-Topic: WARNING in clk_core_disable and clk_core_unprepare with
 imx6q-cpufreq and schedutil governor
Thread-Index: AQHWke5228P8yefMLEywWtwegYabrQ==
Date:   Wed, 23 Sep 2020 21:20:20 +0000
Message-ID: <YT1PR01MB35468E99C4BFF62C0A039DC1EC380@YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=calian.com;
x-originating-ip: [2604:3d09:e37f:fce0::d4a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eb99011-e22b-4be3-8fb2-08d8600679e9
x-ms-traffictypediagnostic: YTBPR01MB2607:
x-microsoft-antispam-prvs: <YTBPR01MB2607BC3E501CB1CB7BDD1AB4EC380@YTBPR01MB2607.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sTyx1Vq2aNBPOCEuQ958KVThVlZqMN39Cww06iddi3Mp4phrTbu8Uf6QKPreW1GG2ekpQTuLErrA61zRt6ZqmC93qiQI91mB0NK1RZrnaIvvplm7iysGR8r4efKTV8TajiC/DsGrDsJnSQqCOkydFgiZnQa7fgfEE1uvY6MuAtAoSItP90cf/KGjUrarOR010RX5eT/sHPTBXwb/s70bW/pdpJvIHFQWY6BEzdXnRtUsmyQLJhtA5zZWRJLPKm8zapAiASr7iLK3coY7L92R1/nf2N6MqAqvyUK/vEwhbQ7dHolGol3Mb2QkBEJ6iQpRwVJCmMqApN43xNkPyQW0GB5P+xBL3HPpQbfoNOyuKb+lIFvPBKuItx2/iBfEXGcRtia8GHOIRpf7oRt+6yraAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39850400004)(396003)(55016002)(86362001)(6506007)(7696005)(71200400001)(66476007)(66946007)(66556008)(186003)(8676002)(76116006)(5660300002)(9686003)(8936002)(316002)(2906002)(33656002)(110136005)(52536014)(66446008)(64756008)(44832011)(45080400002)(83380400001)(478600001)(58493002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 461X1X3wCa3iZHqwyLyAv/zxjOn5yeVtpSOLhggtLW80w94G8A2lq4PvS7gNU5RfcU4SRx8JdlpxaY6d0pfaIGCgl6GBZHi+pzJ+oW0/ZHkLsMuiOWXRjW4RAdgNuAraFDEAqeKYUuAeharq+qwIQDtZeuTH98LTzEsqw9QPJ4zSFcsaDA2ueyQDJIIACZyBv1hwCCWAi0c6lzp1DmzZzsTDpy0qIFX1U2Lq9auBPgWsMdw3gWd+IUlOWNb7dnSx4ZG9SneLRPU+1kD4DFjouQXmBQpAd+pjrapXF8stzzCrr0nT0PCYOLCrbiMfBmyoSl/76+9aNluoqrikbDcy/f0+PQptKe0gB4aXq6cSjcnaZKFYDJQyiX1hHnv8Qx0hV+/fQN5N7EOqCTZ4hukPPFCnagb+nFnTiXJu/yzlWzHEoy2M1yA+AB+fHr73JkZDVaveA27tL7gmLZ7PGcIFNlovVK1GiInIwXUnHcQnTVGiRl/DoKtkA4tiPwPO8XTj/hhot3Cl0ontGAwVqGGU+JDoAcmHKgt3Vec2RMejJ6Vac4Jet0Tb9BYgqQCOQAWbZWD67o0Sb+KY/OYCMOgm+lNvkGIcN/VMLZTZNyvKIy+GzMaAiYIVFWCR+yWBLqslvqYvdofr1OsIqOJmWh1tTMTpPHyBYee1tA9eUml6iw4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb99011-e22b-4be3-8fb2-08d8600679e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 21:20:20.3995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: New6tSYCgAxlCbyqZ8w8sLWKmSs/bkqFcboq2qAr3IAsRB1rfbBu5Y/IpsEzANfrNXc0tl6xZ08THGuVgIeIGUpXgsvwSuICckdEVBgH8ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2607
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello, I have been trying out the schedutil governor using a 5.4.61 kernel =
on an iMX6D platform, but am occasionally seeing the warnings below in the =
kernel log. Is this a known issue? I didn't notice any relevant changes to =
imx6q-cpufreq between 5.4 and master.=0A=
=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 1 PID: 166 at drivers/clk/clk.c:958 clk_core_disable+0xc4/0xc=
c=0A=
pll1_sys already disabled=0A=
Modules linked in: sed_fan_monitor(O) sed_axi_dma_sg(O) sed_pcie_axi(O)=0A=
CPU: 1 PID: 166 Comm: sugov:0 Tainted: G           O      5.4.61 #2=0A=
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)=0A=
[<c0110a74>] (unwind_backtrace) from [<c010b924>] (show_stack+0x10/0x14)=0A=
[<c010b924>] (show_stack) from [<c06e2d20>] (dump_stack+0x90/0xa4)=0A=
[<c06e2d20>] (dump_stack) from [<c01214ec>] (__warn+0xbc/0xd8)=0A=
[<c01214ec>] (__warn) from [<c01215a0>] (warn_slowpath_fmt+0x98/0xc4)=0A=
[<c01215a0>] (warn_slowpath_fmt) from [<c03ef9d0>] (clk_core_disable+0xc4/0=
xcc)=0A=
[<c03ef9d0>] (clk_core_disable) from [<c03efac8>] (clk_core_disable_lock+0x=
18/0x24)=0A=
[<c03efac8>] (clk_core_disable_lock) from [<c051e4c0>] (imx6q_set_target+0x=
4a8/0x500)=0A=
[<c051e4c0>] (imx6q_set_target) from [<c0518568>] (__cpufreq_driver_target+=
0x220/0x534)=0A=
[<c0518568>] (__cpufreq_driver_target) from [<c0164dd8>] (sugov_work+0x48/0=
x54)=0A=
[<c0164dd8>] (sugov_work) from [<c013f9e8>] (kthread_worker_fn+0xf8/0x1fc)=
=0A=
[<c013f9e8>] (kthread_worker_fn) from [<c0140680>] (kthread+0x150/0x190)=0A=
[<c0140680>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)=0A=
Exception stack(0xecb97fb0 to 0xecb97ff8)=0A=
7fa0:                                     00000000 00000000 00000000 000000=
00=0A=
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00=0A=
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000=0A=
---[ end trace 37734437c8c6ed11 ]---=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 1 PID: 166 at drivers/clk/clk.c:816 clk_core_unprepare+0xec/0=
x148=0A=
pll1_sys already unprepared=0A=
Modules linked in: sed_fan_monitor(O) sed_axi_dma_sg(O) sed_pcie_axi(O)=0A=
CPU: 1 PID: 166 Comm: sugov:0 Tainted: G        W  O      5.4.61 #2=0A=
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)=0A=
[<c0110a74>] (unwind_backtrace) from [<c010b924>] (show_stack+0x10/0x14)=0A=
[<c010b924>] (show_stack) from [<c06e2d20>] (dump_stack+0x90/0xa4)=0A=
[<c06e2d20>] (dump_stack) from [<c01214ec>] (__warn+0xbc/0xd8)=0A=
[<c01214ec>] (__warn) from [<c01215a0>] (warn_slowpath_fmt+0x98/0xc4)=0A=
[<c01215a0>] (warn_slowpath_fmt) from [<c03f0ca4>] (clk_core_unprepare+0xec=
/0x148)=0A=
[<c03f0ca4>] (clk_core_unprepare) from [<c03f14f8>] (clk_unprepare+0x24/0x2=
c)=0A=
[<c03f14f8>] (clk_unprepare) from [<c051e4c8>] (imx6q_set_target+0x4b0/0x50=
0)=0A=
[<c051e4c8>] (imx6q_set_target) from [<c0518568>] (__cpufreq_driver_target+=
0x220/0x534)=0A=
[<c0518568>] (__cpufreq_driver_target) from [<c0164dd8>] (sugov_work+0x48/0=
x54)=0A=
[<c0164dd8>] (sugov_work) from [<c013f9e8>] (kthread_worker_fn+0xf8/0x1fc)=
=0A=
[<c013f9e8>] (kthread_worker_fn) from [<c0140680>] (kthread+0x150/0x190)=0A=
[<c0140680>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)=0A=
Exception stack(0xecb97fb0 to 0xecb97ff8)=0A=
7fa0:                                     00000000 00000000 00000000 000000=
00=0A=
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00=0A=
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000=0A=
---[ end trace 37734437c8c6ed12 ]---=0A=
=0A=
=0A=
--=A0=0A=
=0A=
Robert Hancock =0A=
Senior Hardware Designer =0A=
Calian - SED =
