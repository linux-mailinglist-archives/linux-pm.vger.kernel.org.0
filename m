Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A533878FDE
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 17:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbfG2Pxd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 11:53:33 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:58882 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387467AbfG2Pxc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 11:53:32 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6TFiK3T006805;
        Mon, 29 Jul 2019 11:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=2q97VoKTLol6hqzznRi5AK9oOy1nejb2onfq1aZxkCc=;
 b=mwSun/DxgNwZi1a1aa2jrA4KJAtfNdNxqcnS6PL+huLVagv66ytnR87/eu3XjVwJ0WWT
 STurONOZTanwYA+TAi1hMR7rnBTMsrnL1TBV+znWu1IDWf6IwBgW1cAOZejpi4bUGZtQ
 tA/mGXoE1hYG2TRuFNOHZ02n24mJ43xp/0/+gtOPTLs8sQjCNSQFvSKrNKqF3ZWAx3sb
 D9iizCZvLVtANKm+zn+XfyhW9U3OPMF8UMSrlCGGCwa9JMfOyqyQl9UvCUx2SBjC66Re
 LbN2r4X2p3pQuXT8NSuDe+8J1s6NHkqBnnVKn6WDQcOs4dAhZToqAZTnMSU9kvOvWMWW 5g== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2u22qrrdqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jul 2019 11:53:31 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6TFlagu055022;
        Mon, 29 Jul 2019 11:53:31 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0b-00154901.pphosted.com with ESMTP id 2u20yvkcvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 11:53:30 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1338051051"
From:   <Mario.Limonciello@dell.com>
To:     <rafael@kernel.org>, <kai.heng.feng@canonical.com>
CC:     <rjw@rjwysocki.net>, <kbusch@kernel.org>, <keith.busch@intel.com>,
        <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Thread-Topic: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Thread-Index: AQHVQs6UiIesxZzK0UKkUWrQRuKoE6bbv0cAgABS64CAAAEhgIAAAsaAgAEtwoCAAX9fgIADAZew
Date:   Mon, 29 Jul 2019 15:51:50 +0000
Message-ID: <868a042a9422463fa1166653982bb985@AUSX13MPC105.AMER.DELL.COM>
References: <2332799.izEFUvJP67@kreacher> <2428826.VBuqOhikiK@kreacher>
 <20190725195258.GA7307@localhost.localdomain> <15043168.halW6uqc8m@kreacher>
 <D33632F4-E119-4833-816C-79084DA03DE4@canonical.com>
 <CAJZ5v0imsVS-eDB+Lmd5qzAfmb0UpJ5AwV_Vf+v8D21KAtqTOg@mail.gmail.com>
In-Reply-To: <CAJZ5v0imsVS-eDB+Lmd5qzAfmb0UpJ5AwV_Vf+v8D21KAtqTOg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-07-29T15:51:48.5689646Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907290178
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907290178
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDI3LCAyMDE5IDc6NTUg
QU0NCj4gVG86IEthaS1IZW5nIEZlbmcNCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpOyBLZWl0aCBC
dXNjaDsgQnVzY2gsIEtlaXRoOyBDaHJpc3RvcGggSGVsbHdpZzsgU2FnaSBHcmltYmVyZzsNCj4g
bGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBMaW1vbmNpZWxsbywgTWFyaW87IExpbnV4
IFBNOyBMS01MDQo+IFN1YmplY3Q6IFJlOiBbUmVncmVzc2lvbl0gQ29tbWl0ICJudm1lL3BjaTog
VXNlIGhvc3QgbWFuYWdlZCBwb3dlciBzdGF0ZSBmb3INCj4gc3VzcGVuZCIgaGFzIHByb2JsZW1z
DQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gT24gRnJpLCBKdWwgMjYsIDIwMTkg
YXQgNDowMyBQTSBLYWktSGVuZyBGZW5nDQo+IDxrYWkuaGVuZy5mZW5nQGNhbm9uaWNhbC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gYXQgMDQ6MDIsIFJhZmFlbCBKLiBXeXNvY2tpIDxyandAcmp3eXNv
Y2tpLm5ldD4gd3JvdGU6DQo+ID4NCj4gPiA+IE9uIFRodXJzZGF5LCBKdWx5IDI1LCAyMDE5IDk6
NTI6NTkgUE0gQ0VTVCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gPiA+PiBPbiBUaHUsIEp1bCAyNSwg
MjAxOSBhdCAwOTo0ODo1N1BNICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiA+
Pj4gTlZNRSBJZGVudGlmeSBDb250cm9sbGVyOg0KPiA+ID4+PiB2aWQgICAgIDogMHgxYzVjDQo+
ID4gPj4+IHNzdmlkICAgOiAweDFjNWMNCj4gPiA+Pj4gc24gICAgICA6IE1TOTJOMTcxMzEyOTAy
SjBODQo+ID4gPj4+IG1uICAgICAgOiBQQzQwMSBOVk1lIFNLIGh5bml4IDI1NkdCDQo+ID4gPj4+
IGZyICAgICAgOiA4MDAwN0UwMA0KPiA+ID4+PiByYWIgICAgIDogMg0KPiA+ID4+PiBpZWVlICAg
IDogYWNlNDJlDQo+ID4gPj4+IGNtaWMgICAgOiAwDQo+ID4gPj4+IG1kdHMgICAgOiA1DQo+ID4g
Pj4+IGNudGxpZCAgOiAxDQo+ID4gPj4+IHZlciAgICAgOiAxMDIwMA0KPiA+ID4+PiBydGQzciAg
IDogN2ExMjANCj4gPiA+Pj4gcnRkM2UgICA6IDFlODQ4MA0KPiA+ID4+PiBvYWVzICAgIDogMHgy
MDANCj4gPiA+Pj4gY3RyYXR0ICA6IDANCj4gPiA+Pj4gb2FjcyAgICA6IDB4MTcNCj4gPiA+Pj4g
YWNsICAgICA6IDcNCj4gPiA+Pj4gYWVybCAgICA6IDMNCj4gPiA+Pj4gZnJtdyAgICA6IDB4MTQN
Cj4gPiA+Pj4gbHBhICAgICA6IDB4Mg0KPiA+ID4+PiBlbHBlICAgIDogMjU1DQo+ID4gPj4+IG5w
c3MgICAgOiA0DQo+ID4gPj4+IGF2c2NjICAgOiAweDENCj4gPiA+Pj4gYXBzdGEgICA6IDB4MQ0K
PiA+ID4+PiB3Y3RlbXAgIDogMzUyDQo+ID4gPj4+IGNjdGVtcCAgOiAzNTQNCj4gPiA+Pj4gbXRm
YSAgICA6IDANCj4gPiA+Pj4gaG1wcmUgICA6IDANCj4gPiA+Pj4gaG1taW4gICA6IDANCj4gPiA+
Pj4gdG52bWNhcCA6IDANCj4gPiA+Pj4gdW52bWNhcCA6IDANCj4gPiA+Pj4gcnBtYnMgICA6IDAN
Cj4gPiA+Pj4gZWRzdHQgICA6IDEwDQo+ID4gPj4+IGRzdG8gICAgOiAwDQo+ID4gPj4+IGZ3dWcg
ICAgOiAwDQo+ID4gPj4+IGthcyAgICAgOiAwDQo+ID4gPj4+IGhjdG1hICAgOiAwDQo+ID4gPj4+
IG1udG10ICAgOiAwDQo+ID4gPj4+IG14dG10ICAgOiAwDQo+ID4gPj4+IHNhbmljYXAgOiAwDQo+
ID4gPj4+IGhtbWluZHMgOiAwDQo+ID4gPj4+IGhtbWF4ZCAgOiAwDQo+ID4gPj4+IG5zZXRpZG1h
eCA6IDANCj4gPiA+Pj4gYW5hdHQgICA6IDANCj4gPiA+Pj4gYW5hY2FwICA6IDANCj4gPiA+Pj4g
YW5hZ3JwbWF4IDogMA0KPiA+ID4+PiBuYW5hZ3JwaWQgOiAwDQo+ID4gPj4+IHNxZXMgICAgOiAw
eDY2DQo+ID4gPj4+IGNxZXMgICAgOiAweDQ0DQo+ID4gPj4+IG1heGNtZCAgOiAwDQo+ID4gPj4+
IG5uICAgICAgOiAxDQo+ID4gPj4+IG9uY3MgICAgOiAweDFmDQo+ID4gPj4+IGZ1c2VzICAgOiAw
eDENCj4gPiA+Pj4gZm5hICAgICA6IDANCj4gPiA+Pj4gdndjICAgICA6IDB4MQ0KPiA+ID4+PiBh
d3VuICAgIDogNw0KPiA+ID4+PiBhd3VwZiAgIDogNw0KPiA+ID4+PiBudnNjYyAgIDogMQ0KPiA+
ID4+PiBhY3d1ICAgIDogNw0KPiA+ID4+PiBzZ2xzICAgIDogMA0KPiA+ID4+PiBtbmFuICAgIDog
MA0KPiA+ID4+PiBzdWJucW4gIDoNCj4gPiA+Pj4gaW9jY3N6ICA6IDANCj4gPiA+Pj4gaW9yY3N6
ICA6IDANCj4gPiA+Pj4gaWNkb2ZmICA6IDANCj4gPiA+Pj4gY3RyYXR0ciA6IDANCj4gPiA+Pj4g
bXNkYmQgICA6IDANCj4gPiA+Pj4gcHMgICAgMCA6IG1wOjYuMDBXIG9wZXJhdGlvbmFsIGVubGF0
OjUgZXhsYXQ6NSBycnQ6MCBycmw6MA0KPiA+ID4+PiAgICAgICAgICAgcnd0OjAgcndsOjAgaWRs
ZV9wb3dlcjotIGFjdGl2ZV9wb3dlcjotDQo+ID4gPj4+IHBzICAgIDEgOiBtcDozLjgwVyBvcGVy
YXRpb25hbCBlbmxhdDozMCBleGxhdDozMCBycnQ6MSBycmw6MQ0KPiA+ID4+PiAgICAgICAgICAg
cnd0OjEgcndsOjEgaWRsZV9wb3dlcjotIGFjdGl2ZV9wb3dlcjotDQo+ID4gPj4+IHBzICAgIDIg
OiBtcDoyLjQwVyBvcGVyYXRpb25hbCBlbmxhdDoxMDAgZXhsYXQ6MTAwIHJydDoyIHJybDoyDQo+
ID4gPj4+ICAgICAgICAgICByd3Q6MiByd2w6MiBpZGxlX3Bvd2VyOi0gYWN0aXZlX3Bvd2VyOi0N
Cj4gPiA+Pj4gcHMgICAgMyA6IG1wOjAuMDcwMFcgbm9uLW9wZXJhdGlvbmFsIGVubGF0OjEwMDAg
ZXhsYXQ6MTAwMCBycnQ6MyBycmw6Mw0KPiA+ID4+PiAgICAgICAgICAgcnd0OjMgcndsOjMgaWRs
ZV9wb3dlcjotIGFjdGl2ZV9wb3dlcjotDQo+ID4gPj4+IHBzICAgIDQgOiBtcDowLjAwNzBXIG5v
bi1vcGVyYXRpb25hbCBlbmxhdDoxMDAwIGV4bGF0OjUwMDAgcnJ0OjMgcnJsOjMNCj4gPiA+Pj4g
ICAgICAgICAgIHJ3dDozIHJ3bDozIGlkbGVfcG93ZXI6LSBhY3RpdmVfcG93ZXI6LQ0KPiA+ID4+
DQo+ID4gPj4gSG0sIG5vdGhpbmcgc3RhbmRzIG91dCBhcyBzb21ldGhpbmcgd2UgY2FuIHVzZSB0
byBkZXRlcm1pbmUgaWYgd2Ugc2hvdWxkDQo+ID4gPj4gc2tpcCB0aGUgbnZtZSBzcGVjaWZpYyBz
ZXR0aW5ncyBvciBhbGxvdyBEMy4gSSd2ZSBubyBvdGhlciBpZGVhcyBhdCB0aGUNCj4gPiA+PiBt
b21lbnQgZm9yIHdoYXQgd2UgbWF5IGNoZWNrLg0KPiA+ID4NCj4gPiA+IFdlbGwsIGRvIEFTUE0g
c2V0dGluZ3MgbWF0dGVyIGhlcmU/DQo+ID4NCj4gPiBTZWVtcyBsaWtlIGl0J3MgYSByZWdyZXNz
aW9uIGluIHRoZSBmaXJtd2FyZS4NCj4gPg0KPiA+IFRoZSBpc3N1ZSBoYXBwZW5zIGluIHZlcnNp
b24gODAwMDdFMDAgYnV0IG5vdCB2ZXJzaW9uIDgwMDA2RTAwLg0KPiANCj4gU28geW91IG1lYW4g
dGhlIE5WTWUgZmlybXdhcmUsIHRvIGJlIGVudGlyZWx5IHByZWNpc2UuDQoNClllcy4NCg0KPiAN
Cj4gPiBJIGFtIG5vdCBzdXJlIGhvdyB0byBkb3duZ3JhZGUgaXQgdW5kZXIgTGludXggdGhvdWdo
Lg0KPiANCj4gTWUgbmVpdGhlci4NCg0KSSdsbCBhc2sgdGhlIHN0b3JhZ2UgdGVhbSB0byBhc2sg
SHluaXggdG8gbWFrZSBib3RoIHRoZXNlIEZXIGF2YWlsYWJsZSBvbiBMVkZTLg0KRnd1cGQgY2Fu
IHVwZ3JhZGUgYW5kIGRvd25ncmFkZSBmaXJtd2FyZSB3aGVuIHRoZSBiaW5hcmllcyBhcmUgbWFk
ZSBhdmFpbGFibGUuDQoNClRoZXkgY291bGQgcG90ZW50aWFsbHkgYmUgcHVsbGVkIGRpcmVjdGx5
IG91dCBvZiB0aGUgV2luZG93cyBleGVjdXRhYmxlcyB0b28sIGJ1dCBJIGRvbid0DQprbm93IGhv
dyB0byBpZGVudGlmeSB0aGVtIG15c2VsZi4NCg0KPiANCj4gPiBUaGUgZmlybXdhcmUgY2hhbmdl
bG9nIFsxXSBpcyB2ZXJ5IGludGVyZXN0aW5nOg0KPiA+IC0gSW1wcm92ZXMgdGhlIHBlcmZvcm1h
bmNlIG9mIHRoZSBzb2xpZC1zdGF0ZSBkcml2ZSAoU1NEKSBieSBkaXN0cmlidXRpbmcNCj4gPiBw
b3dlciBpbnRvIHRoZSBTU0QgZWZmaWNpZW50bHkgYWNjb3JkaW5nIHRvIHRoZSBwb3dlciBzdGF0
ZSBvZiB0aGUgc3lzdGVtLg0KPiA+DQo+ID4gWzFdDQo+ID4NCj4gaHR0cHM6Ly93d3cuZGVsbC5j
b20vc3VwcG9ydC9ob21lL3VzL2VuLzA0L2RyaXZlcnMvZHJpdmVyc2RldGFpbHM/ZHJpdmVyaWQ9
bQ0KPiBjeG04DQo+IA0KPiBIdWguDQo+IA0KPiBJdCBsb29rcyBsaWtlIHNvbWV0aGluZyBlbHNl
IHByZXZlbnRzIHRoZSBQQ0ggb24gbXkgOTM4MCBmcm9tIHJlYWNoaW5nDQo+IHRoZSByaWdodCBz
dGF0ZSBmb3IgUzBpeCwgdGhvdWdoLiAgSSBzdGlsbCBuZWVkIHRvIGZpbmQgb3V0IHdoYXQgaXQN
Cj4gaXMuDQo=
