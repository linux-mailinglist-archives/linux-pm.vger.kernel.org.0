Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BCB1F68E1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jun 2020 15:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgFKNNb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jun 2020 09:13:31 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:50056 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbgFKNNa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2020 09:13:30 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BDBj5g003458;
        Thu, 11 Jun 2020 09:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=SjraF1upkucVPFVWanIYJjyAexNYV6KBeQgRpXWJkw4=;
 b=QL3BSEg904ZWf5S/kz358HPFGQHUqxeoB3/wjLWEZQAZUfBtgBVPT0V+xf5llEyQS5Ii
 AEkktvxM8npZP4EHjn5UAq0CxD+OBUzy7Rrg/oZcIC+KOEzrjFh3DuAImOWHsUBDteTz
 4sCqRdKVZ5LJAZu+Y1+g76sLUZUw4e72LYiaX4ybX45G3b1XAok/Rmg7rF6jY0Z9Y79c
 ON3QBtNTfPze9D5AYmN50Z0hRm+ZBy91+yq3hUyGaN8zVcQ+hcvO6wREsSoy8tNFh0be
 JCXU2+Lg7vLvprOi9zDxmXtj+GibWzK1LyDUEeNPlIeSup/GCBZxtS1i5zPIOWzPyCCs Wg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 31jjrgxwnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 09:13:30 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BD80cR127854;
        Thu, 11 Jun 2020 09:13:29 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 31kk1jjbej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 09:13:29 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="952170764"
From:   <Mario.Limonciello@dell.com>
To:     <pmenzel@molgen.mpg.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdegoede@redhat.com>, <ckellner@redhat.com>,
        <linux-pm@vger.kernel.org>
Subject: RE: Intel laptop: Starting with `maxcpus=1` and then bringing other
 CPUs online freezes system
Thread-Topic: Intel laptop: Starting with `maxcpus=1` and then bringing other
 CPUs online freezes system
Thread-Index: AQHWP86aCGuiPAIiME6Hf0fCRkjPhajTYeTw
Date:   Thu, 11 Jun 2020 13:13:27 +0000
Message-ID: <a0de2be2c9344980bce7190d19204316@AUSX13MPC105.AMER.DELL.COM>
References: <125e904a-088e-f111-00a4-95c3b18d882f@molgen.mpg.de>
In-Reply-To: <125e904a-088e-f111-00a4-95c3b18d882f@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-11T13:13:24.6910843Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=7cde6931-7b9f-4c04-8544-b4804a33d5bf;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_14:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1011 cotscore=-2147483648 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110102
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110103
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnpl
bEBtb2xnZW4ubXBnLmRlPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxMSwgMjAyMCAzOjU5IEFN
DQo+IFRvOiBUaG9tYXMgR2xlaXhuZXI7IEluZ28gTW9sbmFyOyBCb3Jpc2xhdiBQZXRrb3YNCj4g
Q2M6IHg4NkBrZXJuZWwub3JnOyBMS01MOyBMaW1vbmNpZWxsbywgTWFyaW87IEhhbnMgZGUgR29l
ZGU7IENocmlzdGlhbg0KPiBLZWxsbmVyOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogSW50ZWwgbGFwdG9wOiBTdGFydGluZyB3aXRoIGBtYXhjcHVzPTFgIGFuZCB0aGVuIGJy
aW5naW5nIG90aGVyDQo+IENQVXMgb25saW5lIGZyZWV6ZXMgc3lzdGVtDQo+IA0KPiANCj4gW0VY
VEVSTkFMIEVNQUlMXQ0KPiANCj4gRGVhciBMaW51eCBmb2xrcywNCj4gDQo+IA0KPiBUaGlzIGlz
IGFuIGludGVyZXN0aW5nIG9uZS4gT24gYSBEZWxsIFByZWNpc2lvbiAzNTQwIHdpdGggYSBkZWRp
Y2F0ZWQNCj4gQU1EIGdyYXBoaWNzIGNhcmQsIGFuZCB3aXRoIERlYmlhbiBTaWQvdW5zdGFibGUg
YW5kIExpbnV4IDUuNi4xNCwgdGhlcmUNCj4gYXJlIHNldmVyYWwgc3RyYW5nZSBpc3N1ZXMgKG9u
ZSBleGFtcGxlIFsxXSkuDQo+IA0KPiBTdGFydGluZyB0aGUgc3lzdGVtLCBhbmQgYWRkaW5nIGBt
YXhjcHVzPTFgIHRvIHRoZSBMaW51eCBjb21tYW5kIGxpbmUsDQo+IHRoZSBzeXN0ZW0gc3RhcnRz
Lg0KPiANCj4gVHJ5aW5nIHRvIGJyaW5nIHVwIG1vcmUgQ1BVcywgd29ya3MgZm9yIHRoZSBmaXJz
dCBvbmUsIGJ1dCBmYWlscyBmb3IgdGhlDQo+IHNlY29uZC4gVGhlIHN5c3RlbSBmcmVlemVzIHRo
ZW4uIE5vdGhpbmcgaXMgZHVtcGVkIG9uIHRoZSBMaW51eCB2aXJ0dWFsDQo+IHRlcm1pbmFsLg0K
PiANCj4gSW4gbXkgbGltaXRlZCB0ZXN0cywgdGhpcyBhbHdheXMgaGFwcGVucywgd2hlbiB0aGUg
c3lzdGVtIHJ1bnMgb24NCj4gYmF0dGVyaWVzLCB0aGF0IG1lYW5zLCB3aXRob3V0IHRoZSBwb3dl
ciBjb3JkIHBsdWdnZWQgaW4uIEJ1dCBJIHdhcyBhbHNvDQo+IGFibGUgdG8gcmVwcm9kdWNlIGl0
IHdpdGggdGhlIFVTQiBUeXBlLUMgcG93ZXIgY2FibGUgcGx1Z2dlZCBpbi4gQnV0DQo+IHNvbWV0
aW1lcyBpdCB3b3JrcyAodG8gYnJpbmcgYWxsIG90aGVyIHNldmVuIENQVXMgb25saW5lKS4NCj4g
DQo+IFBsZWFzZSBmaW5kIHRoZSBMaW51eCBtZXNzYWdlcyB1cCB0byBicmluZ2luZyBDUFUgMSBv
bmxpbmUgYXR0YWNoZWQgd2l0aA0KPiBubyBwb3dlciBjb3JkIHBsdWdnZWQgaW4sIGFuZCB0aGUg
bWVzc2FnZXMgb2YgYSBzdWNjZXNzZnVsIG9wZXJhdGlvbi4NCj4gDQo+IElzIHRoaXMgZXhwZWN0
ZWQ/IEnigJlkIGFwcHJlY2lhdGVkIHRpcHMsIGlmIGl04oCZcyBwb3NzaWJsZSB0byBkZWJ1ZyB0
aGlzDQo+IGZ1cnRoZXIuDQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0KPiAN
Cj4gDQo+IFsxXTogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvdWJ1bnR1Lytzb3VyY2UvbGlu
dXgvK2J1Zy8xODgzMDY1DQoNCkZyb20gc29tZSBvdGhlciBzaW1pbGFyIHJlcG9ydHMgSSd2ZSBo
ZWFyZCB0aGlzIGNvdWxkIGJlIHJlbGF0ZWQgdG8gdGhlIHVjb2RlDQpsb2FkaW5nIGNhdXNpbmcg
YSBmcmVlemUuICBJIHdvdWxkIHN1Z2dlc3QgdHJ5aW5nIHRvIGRpc2FibGUgdGhlIEludGVsIHVj
b2RlDQpsb2FkZXIgd2l0aCB0aGUgaW5pdHJhbWZzIGFzIGEgZGVidWdnaW5nIHRhY3RpYy4NCg==
