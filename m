Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FA83377
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 16:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfHFOC2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 10:02:28 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:57250 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbfHFOC1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 10:02:27 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76E02CL019792;
        Tue, 6 Aug 2019 10:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=iYMNMZYnKpwv2bjj9FYprIo2vpkrKBVUFUkpE1z8JqE=;
 b=XDRw6tCx+0IknZAtmfR3qBWl219FOzHGTGw8fv474NcmsEanvS6n7+w8RWchlwnmo2Qw
 XM4732opo1+LqQ04EYVLY0p8KwI254UN3LNG7k0l7NTtmCkIvCSkws0iaKQOh/RsY4az
 71kG8W2j837NzECe+UsA6iSFh48J6mNst+5owZq4XcLMPSuz7NcqurkmHKBBXGULcsuX
 YOEOX+xEyvL5DEdTxaZ8zF4wb4k6lbanZ0Os3OEGSMkpPzroJU8fp7xoxCgvxtFIa0/d
 XKD/+Qrc2H7kR+oE9SnnzX8KPNoDCnKeBJuDdDvxVhb/eZfpDcESw1i66pGWXS6D31ov ZA== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2u55kj3xaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 10:02:25 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76Dwchg096647;
        Tue, 6 Aug 2019 10:02:25 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0b-00154901.pphosted.com with ESMTP id 2u7ahtgf9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 10:02:24 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="379332134"
From:   <Mario.Limonciello@dell.com>
To:     <rafael@kernel.org>, <kai.heng.feng@canonical.com>
CC:     <kbusch@kernel.org>, <keith.busch@intel.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rajatja@google.com>
Subject: RE: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Thread-Topic: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Thread-Index: AQHVQs6UiIesxZzK0UKkUWrQRuKoE6bbsW+A///PBcCAAGObgIAHcfaAgABB9YD//9WSkIAAb9eAgAAIQgD//8kpUAALdBYAADIaeYAAAeOLAAAAd84AABYXlgAAEZduAAAHfW7gAALiG4AAGiqrgAAASjWAAKf60QAABLdLAAAXuLOg
Date:   Tue, 6 Aug 2019 14:02:22 +0000
Message-ID: <1d05e26a91f94e5b92eaf5854fa85289@AUSX13MPC105.AMER.DELL.COM>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
 <CAJZ5v0hxYGBXau39sb80MQ8jbZZCzH0JU2DYZvn9JOtYT2+30g@mail.gmail.com>
 <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com>
 <CAJZ5v0hFYEv_+vFkrxaCn_pNAbyqmO_cLb5GOLNn_xxRRwjh2g@mail.gmail.com>
 <38d4b4b107154454a932781acde0fa5a@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0jmO4FMOVYs62wkvPrUW81scD2H7cJyRc+tfoj+vODVbQ@mail.gmail.com>
 <43A8DF53-8463-4314-9E8E-47A7D3C5A709@canonical.com>
 <CAJZ5v0ipG-MJjERBL9fjx29QktaYEKSmMCbWiEGPHsbF=Xfxtw@mail.gmail.com>
 <1FA3D56B-80C6-496C-8772-2F773AA8043C@canonical.com>
 <CAJZ5v0g_yAP=zgYDXtJWtwceQp4wWPWFghDDD0opdZ4zT-yo5Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0g_yAP=zgYDXtJWtwceQp4wWPWFghDDD0opdZ4zT-yo5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-06T14:02:20.7039904Z;
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060140
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060141
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCA1LCAyMDE5IDQ6
MjkgUE0NCj4gVG86IEthaS1IZW5nIEZlbmcNCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpOyBMaW1v
bmNpZWxsbywgTWFyaW87IEtlaXRoIEJ1c2NoOyBLZWl0aCBCdXNjaDsgQ2hyaXN0b3BoDQo+IEhl
bGx3aWc7IFNhZ2kgR3JpbWJlcmc7IGxpbnV4LW52bWU7IExpbnV4IFBNOyBMaW51eCBLZXJuZWwg
TWFpbGluZyBMaXN0OyBSYWphdCBKYWluDQo+IFN1YmplY3Q6IFJlOiBbUmVncmVzc2lvbl0gQ29t
bWl0ICJudm1lL3BjaTogVXNlIGhvc3QgbWFuYWdlZCBwb3dlciBzdGF0ZSBmb3INCj4gc3VzcGVu
ZCIgaGFzIHByb2JsZW1zDQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gT24gTW9u
LCBBdWcgNSwgMjAxOSBhdCA5OjE0IFBNIEthaS1IZW5nIEZlbmcNCj4gPGthaS5oZW5nLmZlbmdA
Y2Fub25pY2FsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBhdCAxOTowNCwgUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+ID4gT24gRnJpLCBBdWcgMiwg
MjAxOSBhdCAxMjo1NSBQTSBLYWktSGVuZyBGZW5nDQo+ID4gPiA8a2FpLmhlbmcuZmVuZ0BjYW5v
bmljYWwuY29tPiB3cm90ZToNCj4gPiA+PiBhdCAwNjoyNiwgUmFmYWVsIEouIFd5c29ja2kgPHJh
ZmFlbEBrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+Pg0KPiA+ID4+PiBPbiBUaHUsIEF1ZyAxLCAy
MDE5IGF0IDk6MDUgUE0gPE1hcmlvLkxpbW9uY2llbGxvQGRlbGwuY29tPiB3cm90ZToNCj4gPiA+
Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4+Pj4+IEZyb206IFJhZmFlbCBK
LiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gPiA+Pj4+PiBTZW50OiBUaHVyc2RheSwg
QXVndXN0IDEsIDIwMTkgMTI6MzAgUE0NCj4gPiA+Pj4+PiBUbzogS2FpLUhlbmcgRmVuZzsgS2Vp
dGggQnVzY2g7IExpbW9uY2llbGxvLCBNYXJpbw0KPiA+ID4+Pj4+IENjOiBLZWl0aCBCdXNjaDsg
Q2hyaXN0b3BoIEhlbGx3aWc7IFNhZ2kgR3JpbWJlcmc7IGxpbnV4LW52bWU7IExpbnV4DQo+ID4g
Pj4+Pj4gUE07IExpbnV4DQo+ID4gPj4+Pj4gS2VybmVsIE1haWxpbmcgTGlzdDsgUmFqYXQgSmFp
bg0KPiA+ID4+Pj4+IFN1YmplY3Q6IFJlOiBbUmVncmVzc2lvbl0gQ29tbWl0ICJudm1lL3BjaTog
VXNlIGhvc3QgbWFuYWdlZCBwb3dlcg0KPiA+ID4+Pj4+IHN0YXRlIGZvcg0KPiA+ID4+Pj4+IHN1
c3BlbmQiIGhhcyBwcm9ibGVtcw0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBbRVhU
RVJOQUwgRU1BSUxdDQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBPbiBUaHUsIEF1ZyAxLCAyMDE5IGF0
IDExOjA2IEFNIEthaS1IZW5nIEZlbmcNCj4gPiA+Pj4+PiA8a2FpLmhlbmcuZmVuZ0BjYW5vbmlj
YWwuY29tPiB3cm90ZToNCj4gPiA+Pj4+Pj4gYXQgMDY6MzMsIFJhZmFlbCBKLiBXeXNvY2tpIDxy
YWZhZWxAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+PiBPbiBUaHUs
IEF1ZyAxLCAyMDE5IGF0IDEyOjIyIEFNIEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4N
Cj4gPiA+Pj4+Pj4+IHdyb3RlOg0KPiA+ID4+Pj4+Pj4+IE9uIFdlZCwgSnVsIDMxLCAyMDE5IGF0
IDExOjI1OjUxUE0gKzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiA+ID4+Pj4+Pj4+
PiBBIGNvdXBsZSBvZiByZW1hcmtzIGlmIHlvdSB3aWxsLg0KPiA+ID4+Pj4+Pj4+Pg0KPiA+ID4+
Pj4+Pj4+PiBGaXJzdCwgd2UgZG9uJ3Qga25vdyB3aGljaCBjYXNlIGlzIHRoZSBtYWpvcml0eSBh
dCB0aGlzIHBvaW50LiAgRm9yDQo+ID4gPj4+Pj4+Pj4+IG5vdywgdGhlcmUgaXMgb25lIGV4YW1w
bGUgb2YgZWFjaCwgYnV0IGl0IG1heSB2ZXJ5IHdlbGwgdHVybiBvdXQNCj4gPiA+Pj4+Pj4+Pj4g
dGhhdA0KPiA+ID4+Pj4+Pj4+PiB0aGUgU0sgSHluaXggQkM1MDEgYWJvdmUgbmVlZHMgdG8gYmUg
cXVpcmtlZC4NCj4gPiA+Pj4+Pj4+Pj4NCj4gPiA+Pj4+Pj4+Pj4gU2Vjb25kLCB0aGUgcmVmZXJl
bmNlIGhlcmUgcmVhbGx5IGlzIDUuMiwgc28gaWYgdGhlcmUgYXJlIGFueQ0KPiA+ID4+Pj4+Pj4+
PiBzeXN0ZW1zDQo+ID4gPj4+Pj4+Pj4+IHRoYXQgYXJlIG5vdCBiZXR0ZXIgb2ZmIHdpdGggNS4z
LXJjIHRoYW4gdGhleSB3ZXJlIHdpdGggNS4yLA0KPiA+ID4+Pj4+Pj4+PiB3ZWxsLCB3ZQ0KPiA+
ID4+Pj4+Pj4+PiBoYXZlIG5vdCBtYWRlIHByb2dyZXNzLiAgSG93ZXZlciwgaWYgdGhlcmUgYXJl
IHN5c3RlbXMgdGhhdCBhcmUNCj4gPiA+Pj4+Pj4+Pj4gd29yc2UNCj4gPiA+Pj4+Pj4+Pj4gb2Zm
IHdpdGggNS4zLCB0aGF0J3MgYmFkLiAgSW4gdGhlIGZhY2Ugb2YgdGhlIGxhdGVzdCBmaW5kaW5n
cyB0aGUNCj4gPiA+Pj4+Pj4+Pj4gb25seQ0KPiA+ID4+Pj4+Pj4+PiB3YXkgdG8gYXZvaWQgdGhh
dCBpcyB0byBiZSBiYWNrd2FyZHMgY29tcGF0aWJsZSB3aXRoIDUuMiBhbmQgdGhhdCdzDQo+ID4g
Pj4+Pj4+Pj4+IHdoZXJlIG15IHBhdGNoIGlzIGdvaW5nLiAgVGhhdCBjYW5ub3QgYmUgYWNoaWV2
ZWQgYnkgcXVpcmtpbmcgYWxsDQo+ID4gPj4+Pj4+Pj4+IGNhc2VzIHRoYXQgYXJlIHJlcG9ydGVk
IGFzICJiYWQiLCBiZWNhdXNlIHRoZXJlIHN0aWxsIG1heSBiZQ0KPiA+ID4+Pj4+Pj4+PiB1bnJl
cG9ydGVkIG9uZXMuDQo+ID4gPj4+Pj4+Pj4NCj4gPiA+Pj4+Pj4+PiBJIGhhdmUgdG8gYWdyZWUu
IEkgdGhpbmsgeW91ciBwcm9wb3NhbCBtYXkgYWxsb3cgUENJIEQzY29sZCwNCj4gPiA+Pj4+Pj4+
DQo+ID4gPj4+Pj4+PiBZZXMsIGl0IG1heS4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4gU29tZWhv
dyB0aGUgOTM4MCB3aXRoIFRvc2hpYmEgTlZNZSBuZXZlciBoaXRzIFNMUF9TMCB3aXRoIG9yDQo+
IHdpdGhvdXQNCj4gPiA+Pj4+Pj4gUmFmYWVs4oCZcyBwYXRjaC4NCj4gPiA+Pj4+Pj4gQnV0IHRo
ZSDigJxyZWFs4oCdIHMyaWRsZSBwb3dlciBjb25zdW1wdGlvbiBkb2VzIGltcHJvdmUgd2l0aCB0
aGUgcGF0Y2guDQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBEbyB5b3UgbWVhbiB0aGlzIHBhdGNoOg0K
PiA+ID4+Pj4+DQo+ID4gPj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcG0vNzBE
NTM2QkUtOERDNy00Q0EyLTg0QTktDQo+ID4gPj4+Pj4NCj4gQUZCMDY3QkE1MjBFQGNhbm9uaWNh
bC5jb20vVC8jbTQ1NmFhNWM2OTk3M2EzYjY4ZjJjZGQ0NzEzYTFjZTgzYmU1MTQ1DQo+ID4gPj4+
Pj4gOGYNCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+IG9yIHRoZSAkc3ViamVjdCBvbmUgd2l0aG91dCB0
aGUgYWJvdmU/DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+Pj4gQ2FuIHdlIHVzZSBhIERNSSBiYXNlZCBx
dWlyayBmb3IgdGhpcyBwbGF0Zm9ybT8gSXQgc2VlbXMgbGlrZSBhDQo+ID4gPj4+Pj4+IHBsYXRm
b3JtDQo+ID4gPj4+Pj4+IHNwZWNpZmljIGlzc3VlLg0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4gV2Ug
c2VlbSB0byBzZWUgdG9vIG1hbnkgInBsYXRmb3JtLXNwZWNpZmljIGlzc3VlcyIgaGVyZS4gOi0p
DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBUbyBtZSwgdGhlIHN0YXR1cyBxdW8gKGllLiB3aGF0IHdl
IGhhdmUgaW4gNS4zLXJjMikgaXMgbm90IGRlZmVuc2libGUuDQo+ID4gPj4+Pj4gU29tZXRoaW5n
IG5lZWRzIHRvIGJlIGRvbmUgdG8gaW1wcm92ZSB0aGUgc2l0dWF0aW9uLg0KPiA+ID4+Pj4NCj4g
PiA+Pj4+IFJhZmFlbCwgd291bGQgaXQgYmUgcG9zc2libGUgdG8gdHJ5IHBvcHBpbmcgb3V0IFBD
NDAxIGZyb20gdGhlIDkzODAgYW5kDQo+ID4gPj4+PiBpbnRvIGEgOTM2MCB0bw0KPiA+ID4+Pj4g
Y29uZmlybSB0aGVyZSBhY3R1YWxseSBiZWluZyBhIHBsYXRmb3JtIGltcGFjdCBvciBub3Q/DQo+
ID4gPj4+DQo+ID4gPj4+IE5vdCByZWFsbHksIHNvcnJ5Lg0KPiA+ID4+Pg0KPiA+ID4+Pj4gSSB3
YXMgaG9waW5nIHRvIGhhdmUgc29tZXRoaW5nIHVzZWZ1bCBmcm9tIEh5bml4IGJ5IG5vdyBiZWZv
cmUNCj4gPiA+Pj4+IHJlc3BvbmRpbmcsIGJ1dCBvaCB3ZWxsLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+
IEluIHRlcm1zIG9mIHdoYXQgaXMgdGhlIG1ham9yaXR5LCBJIGRvIGtub3cgdGhhdCBiZXR3ZWVu
IGZvbGtzIGF0IERlbGwsDQo+ID4gPj4+PiBHb29nbGUsIENvbXBhbCwNCj4gPiA+Pj4+IFdpc3Ry
b24sIENhbm9uaWNhbCwgTWljcm9uLCBIeW5peCwgVG9zaGliYSwgTGl0ZU9uLCBhbmQgV2VzdGVy
biBEaWdpdGFsDQo+ID4gPj4+PiB3ZSB0ZXN0ZWQgYSB3aWRlDQo+ID4gPj4+PiB2YXJpZXR5IG9m
IFNTRHMgd2l0aCB0aGlzIHBhdGNoIHNlcmllcy4gIEkgd291bGQgbGlrZSB0byB0aGluayB0aGF0
IHRoZXkNCj4gPiA+Pj4+IGFyZSByZXByZXNlbnRhdGl2ZSBvZg0KPiA+ID4+Pj4gd2hhdCdzIGJl
aW5nIG1hbnVmYWN0dXJlZCBpbnRvIG1hY2hpbmVzIG5vdy4NCj4gPiA+Pj4NCj4gPiA+Pj4gV2Vs
bCwgd2hhdCBhYm91dCBkcml2ZXMgYWxyZWFkeSBpbiB0aGUgZmllbGQ/ICBNeSBjb25jZXJuIGlz
IG1vc3RseQ0KPiA+ID4+PiBhYm91dCB0aG9zZSBvbmVzLg0KPiA+ID4+Pg0KPiA+ID4+Pj4gTm90
YWJseSB0aGUgTGl0ZU9uIENMMSB3YXMgdGVzdGVkIHdpdGggdGhlIEhNQiBmbHVzaGluZyBzdXBw
b3J0IGFuZA0KPiA+ID4+Pj4gYW5kIEh5bml4IFBDNDAxIHdhcyB0ZXN0ZWQgd2l0aCBvbGRlciBm
aXJtd2FyZSB0aG91Z2guDQo+ID4gPj4+Pg0KPiA+ID4+Pj4+Pj4+IEluIHdoaWNoIGNhc2Ugd2Ug
ZG8gbmVlZCB0byByZWludHJvZHVjZSB0aGUgSE1CIGhhbmRsaW5nLg0KPiA+ID4+Pj4+Pj4NCj4g
PiA+Pj4+Pj4+IFJpZ2h0Lg0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiBUaGUgcGF0Y2ggYWxvbmUg
ZG9lc27igJl0IGJyZWFrIEhNQiBUb3NoaWJhIE5WTWUgSSB0ZXN0ZWQuIEJ1dCBJIHRoaW5rDQo+
ID4gPj4+Pj4+IGl04oCZcw0KPiA+ID4+Pj4+PiBzdGlsbCBzYWZlciB0byBkbyBwcm9wZXIgSE1C
IGhhbmRsaW5nLg0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4gV2VsbCwgc28gY2FuIGFueW9uZSBwbGVh
c2UgcHJvcG9zZSBzb21ldGhpbmcgc3BlY2lmaWM/ICBMaWtlIGFuDQo+ID4gPj4+Pj4gYWx0ZXJu
YXRpdmUgcGF0Y2g/DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gVGhpcyB3YXMgcHJvcG9zZWQgYSBmZXcg
ZGF5cyBhZ286DQo+ID4gPj4+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwv
bGludXgtbnZtZS8yMDE5LUp1bHkvMDI2MDU2Lmh0bWwNCj4gPiA+Pj4+DQo+ID4gPj4+PiBIb3dl
dmVyIHdlJ3JlIHN0aWxsIG5vdCBzdXJlIHdoeSBpdCBpcyBuZWVkZWQsIGFuZCBpdCB3aWxsIHRh
a2Ugc29tZQ0KPiA+ID4+Pj4gdGltZSB0byBnZXQNCj4gPiA+Pj4+IGEgcHJvcGVyIGZhaWx1cmUg
YW5hbHlzaXMgZnJvbSBMaXRlT24gIHJlZ2FyZGluZyB0aGUgQ0wxLg0KPiA+ID4+Pg0KPiA+ID4+
PiBUaGFua3MgZm9yIHRoZSB1cGRhdGUsIGJ1dCBJTU8gd2Ugc3RpbGwgbmVlZCB0byBkbyBzb21l
dGhpbmcgYmVmb3JlDQo+ID4gPj4+IGZpbmFsIDUuMyB3aGlsZSB0aGUgaW52ZXN0aWdhdGlvbiBj
b250aW51ZXMuDQo+ID4gPj4+DQo+ID4gPj4+IEhvbmVzdGx5LCBhdCB0aGlzIHBvaW50IEkgd291
bGQgdm90ZSBmb3IgZ29pbmcgYmFjayB0byB0aGUgNS4yDQo+ID4gPj4+IGJlaGF2aW9yIGF0IGxl
YXN0IGJ5IGRlZmF1bHQgYW5kIG9ubHkgcnVubmluZyB0aGUgbmV3IGNvZGUgb24gdGhlDQo+ID4g
Pj4+IGRyaXZlcyBrbm93biB0byByZXF1aXJlIGl0IChiZWNhdXNlIHRoZXkgd2lsbCBibG9jayBQ
QzEwIG90aGVyd2lzZSkuDQo+ID4gPj4+DQo+ID4gPj4+IFBvc3NpYmx5IChpZGVhbGx5KSB3aXRo
IGFuIG9wdGlvbiBmb3IgdXNlcnMgd2hvIGNhbid0IGdldCBiZXlvbmQgUEMzDQo+ID4gPj4+IHRv
IHRlc3Qgd2hldGhlciBvciBub3QgdGhlIG5ldyBjb2RlIGhlbHBzIHRoZW0uDQo+ID4gPj4NCj4g
PiA+PiBJIGp1c3QgZm91bmQgb3V0IHRoYXQgdGhlIFhQUyA5MzgwIGF0IG15IGhhbmQgbmV2ZXIg
cmVhY2hlcyBTTFBfUzAgYnV0DQo+ID4gPj4gb25seQ0KPiA+ID4+IFBDMTAuDQo+ID4gPg0KPiA+
ID4gVGhhdCdzIHRoZSBjYXNlIGZvciBtZSB0b28uDQo+ID4gPg0KPiA+ID4+IFRoaXMgaGFwcGVu
cyB3aXRoIG9yIHdpdGhvdXQgcHV0dGluZyB0aGUgZGV2aWNlIHRvIEQzLg0KPiA+ID4NCj4gPiA+
IE9uIG15IHN5c3RlbSwgdGhvdWdoLCBpdCBvbmx5IGNhbiBnZXQgdG8gUEMzIHdpdGhvdXQgcHV0
dGluZyB0aGUgTlZNZQ0KPiA+ID4gaW50byBEMyAoYXMgcmVwb3J0ZWQgcHJldmlvdXNseSkuDQo+
ID4NCj4gPiBJIGZvcmdvdCB0byBhc2ssIHdoYXQgQklPUyB2ZXJzaW9uIGRvZXMgdGhlIHN5c3Rl
bSBoYXZlPw0KPiA+IEkgZG9u4oCZdCBzZWUgdGhpcyBpc3N1ZSBvbiBCSU9TIHYxLjUuMC4NCj4g
DQo+IEl0IGlzIDEuNS4wIGhlcmUgdG9vLg0KDQpBbGwsIHJlZ2FyZGluZyB0aGUgbmVlZCBmb3Ig
dGhlIHBhdGNoIHByb3Bvc2VkIGJ5IFJhZmFlbCBvbiBQQzQwMSwgSSBoYXZlIHNvbWUgdXBkYXRl
cw0KdG8gc2hhcmUgZnJvbSBIeW5peC4NCkZpcnN0IG9mZiAtIHRoZSBmaXJtd2FyZSBjaGFuZ2Vs
b2cgaXMgbWlzbGVhZGluZyBmcm9tIDgwMDA2RTAwIHRvIDgwMDA3RTAwLg0KDQpUaGUgY2hhbmdl
IHdhcyBtYWRlIGluIHRoZSBmaXJtd2FyZSBzcGVjaWZpY2FsbHkgYmVjYXVzZSBvZiBhIGNoYW5n
ZSBpbiBiZWhhdmlvciBmcm9tDQpJbnRlbCBLQkwgdG8gQ0ZMIGFuZCBXSEwuICBPbiBDRkwvV0hM
IHRoZSBwZXJpb2Qgb2YgdGltZSB0aGF0IFJlZkNsayB3YXMgdHVybmVkIG9uIGFmdGVyIEwxLjIN
CndhcyBsYXJnZXIgdGhhbiBLQkwgcGxhdGZvcm1zLiAgU28gdGhpcyBtZWFudCB0aGF0IEh5bml4
IGNvdWxkbid0IGxvY2sgdXAgZnJvbSBDTEtSRVEjDQp0byBSZWZDbGsgYXMgcXVpY2tseSBvbiBD
RkwvV0hMLiAgU28gdGhlcmUgaXMgYSAibGFyZ2VyIiBmaXhlZCBkZWxheSBpbnRyb2R1Y2VkIGlu
IHRoZWlyIEZXLg0KDQpUbyB0aG9zZSB0aGF0IGRvbid0IGtub3cgLSBYUFMgOTM4MCBpcyBhIFdI
TCBwbGF0Zm9ybS4NCg0KU2Vjb25kIC0gYSBoeXBvdGhlc2lzIG9mIHdoYXQgaXMgaGFwcGVuaW5n
IHdpdGggdGhlIHBhdGNoIHByb3Bvc2VkIGJ5IFJhZmFlbCBpcyB0aGF0IHRoZSBsaW5rDQppcyBv
bmx5IHRyYW5zaXRpb25pbmcgdG8gTDEuMCByYXRoZXIgdGhhbiBMMS4yLiAgVGhpcyBtYXkgc2F0
aXNmeSB0aGUgUE1DIGJ1dCBpdCBzaG91bGRuJ3QgbGVhZCB0bw0KdGhlIGxvd2VzdCBhY3R1YWwg
ZGV2aWNlIHBvd2VyIHN0YXRlLg0KDQo=
