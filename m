Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751B379DCE6
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 01:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjILX7q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 19:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjILX7q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 19:59:46 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB881705
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 16:59:42 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230912235939epoutp04424611c87b933a3f63bb6970a440903b~ETDuvOACW2848428484epoutp04N
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 23:59:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230912235939epoutp04424611c87b933a3f63bb6970a440903b~ETDuvOACW2848428484epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694563179;
        bh=pYOGl38dh4jO/T0McbK34oYeeaaqVF40Zmf63e4Qwj4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ClbptqeEb62lMpIgUb3MOCpY5sydqImXXKwqw3uEi5Xt76TomSdv7cruU/XulAKeG
         MJgV6mtYuIPBk+qCGgnEut9w3l8iNxbNaL6cHDfLpNuu45nEtCzto2YGKVRoY5Y8lh
         zeCptkWWyZHoR7iuQSpD8yA7bWryrVXnpjguDZw4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230912235938epcas1p42ac8d246a9dcbfde763dbd4c6cb82c69~ETDuMsSup0589705897epcas1p4N;
        Tue, 12 Sep 2023 23:59:38 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.233]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RlgYP3QnWz4x9Q0; Tue, 12 Sep
        2023 23:59:37 +0000 (GMT)
X-AuditID: b6c32a39-955f97000000255f-f8-6500fb695a23
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.EE.09567.96BF0056; Wed, 13 Sep 2023 08:59:37 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Overflow issue in trans_stat_show
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     "Jiazi.Li" <jqqlijiazi@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230912090753.GA14603@Jiazi.Li>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230912235937epcms1p2e97f0cd165ba4f7b79154189b8eccc88@epcms1p2>
Date:   Wed, 13 Sep 2023 08:59:37 +0900
X-CMS-MailID: 20230912235937epcms1p2e97f0cd165ba4f7b79154189b8eccc88
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7bCmnm7mb4ZUg6uTJC2uf3nOarF90RU2
        i7NNb9gtPvceYXRg8dg56y67R9+WVYwenzfJBTBHZdtkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        pRak5BSYFugVJ+YWl+al6+WlllgZGhgYmQIVJmRndHctYi7o5KpYd2cySwPjc84uRk4OCQET
        iZPPFrJ3MXJxCAnsYJTYtvYXcxcjBwevgKDE3x3CIDXCAnoSk1uusoLYQgJKEg039zFDxPUl
        Oh5sYwSx2QR0JbZuuMsCYosIVEjseXcQrIZZwFLi3dK3TBC7eCVmtD9lgbClJbYv3wrWywk0
        /9fx38wQcVGJm6vfssPY74/NZ4SwRSRa752FqhGUePBzN1RcSuLJzslsIPdLCGxjlNhxZA6U
        s59RYsrDNqhJ+hJn5p5kA7F5BXwlPk+YAxZnEVCV+HvlDBtEjYvEll2PGSGu1pZYtvA1OCCY
        BTQl1u/ShwjzSbz72sMK88yOeU+gHlOTOLR7CdQqGYnT0xdCHeohcf7iSiZIwJVKNDffZJ7A
        KD8LEbyzkCybhbBsASPzKkax1ILi3PTUYsMCU3iMJufnbmIEpzYtyx2M099+0DvEyMTBeIhR
        goNZSYS35NDfFCHelMTKqtSi/Pii0pzU4kOMpkBvTmSWEk3OBybXvJJ4QxNLAxMzI2MTC0Mz
        QyVx3nNve1OEBNITS1KzU1MLUotg+pg4OKUamGZwMF2PfBT0xjPu+yMefzvpc0lZunJa3z+4
        G+cmN7gtlXQv7j9x4/VLiY8aHGwqpsnTPSdPfOdcKed0NdrMLUNv+etliZZ35hjfXHZd6myP
        VEO7NZOJ0fUbTH4Hxbe6HZ7a+6zTyeo/k9elvmDn/wwy7YkXZWqMFl9f9/z7ksMn8hqjKwvf
        nM7xP723bz3T4Yu/ww10iqs3e7rnTd99zlb0vWN/j9lL6VefX7myvJ7bLRmRcPXDvXUCmgf9
        NQQK+7iLn8h9mxgU7L8pnaMqdbvcpAC3xbGaYX/v3HibtM/s+avD/RpaAU94jINevTkvO8ls
        AV+ewUbm70e7zkucZX51WrJ9qaCgO4dLwOOPSizFGYmGWsxFxYkA0/ZsAfYDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230912090800epcas1p14c2a96e9dc56f7f23e66907760c168bb
References: <20230912090753.GA14603@Jiazi.Li>
        <CGME20230912090800epcas1p14c2a96e9dc56f7f23e66907760c168bb@epcms1p2>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=C2=A0=0D=0A=C2=A0=0D=0A>---------=20Original=20Message=20---------=0D=0A>S=
ender=20:=20Jiazi.Li=C2=A0<jqqlijiazi=40gmail.com>=0D=0A>Date=20=20=20:=202=
023-09-12=2018:08=20(GMT+9)=0D=0A>Title=20=20:=20Overflow=20issue=20in=20tr=
ans_stat_show=0D=0A>=C2=A0=0D=0A>Hi,=0D=0A>=0D=0A>In=20trans_stat_show,=20i=
f=20there=20are=20more=20than=2019=20states,=20len=20will=20be=0D=0A>greate=
r=20than=204096,=20causing=20overflow=20write=20issue:=0D=0A>=5B=C2=A0=2070=
2.286732=5D=20cat:=20dev_attr_show:=20trans_stat_show.cfi_jt+0x0/0x8=20retu=
rned=20bad=20count=0D=0A>=5B=C2=A0=20702.287867=5D=20cat:=20fill_read_buffe=
r:=20dev_attr_show.cfi_jt+0x0/0x8=20returned=20bad=20count=0D=0A>And=20then=
=20system=20oops=20due=20to=20memory=20corruption.=0D=0A>=0D=0A>It=20seems=
=20difficult=20to=20read=20more=20than=20PAGE_SIZE=20bytes=20through=20sysf=
s,=0D=0A>could=20we=20move=20trans_stat=20to=20debugfs?=0D=0A>For=20example=
,=20in=20the=20following=20dir:=0D=0A>debugfs_root/devfreq/device_name/tran=
s_stat=0D=0A=0D=0AYes,=20it'd=20be=20better=20if=0D=0A1)=20let=20sysfs=20tr=
ans_stat_show=20show=20in=20shorter=20form=20for=20such=20cases=0D=0A2)=20c=
reate=20a=20debugfs=20entry=20for=20performance=20statistics=20(trans_stat)=
.=0D=0A=0D=0A=0D=0ACheers,=0D=0AMyungJoo
