Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C7521570E
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 14:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgGFMJx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 08:09:53 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:55462 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgGFMJw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 08:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594037390; x=1625573390;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=wce+64mqp6YBAfu65sUE813MnoIVNEZcxsQ/w8oScIo=;
  b=d9puq5ETJEHJ+OII+bylSAIzXmzymBT7y++JvkboohZVkRlHsupXasCb
   I0ugy4XZ1HIpvwm1nfRGZH+zZ/rDNiSCvqiYltHXP2zMQjqQybgOSD+9u
   RQhNsFCstiFECk9y+drVcuAjd+9wM1FdSftvPE1CBLB+ONTP2xHqiWxcU
   M=;
IronPort-SDR: gLafyR8Q4Sdz4VtPjYINQ0zQG/0smgzWXLCd1HajfoyMhjeFdXHqfLbqCZDY14a7ZfcV8pFNml
 P19LFjc73/gA==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="56363549"
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 06 Jul 2020 12:09:47 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 02FC6A2110;
        Mon,  6 Jul 2020 12:09:40 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:09:40 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.160.65) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:09:32 +0000
To:     Jann Horn <jannh@google.com>,
        "Catangiu, Adrian Costin" <acatan@amazon.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <CAG48ez2CpHX9i3YgkNyMHPz63ohjkaSZscMtwSHOFYN4VQow3Q@mail.gmail.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <c6254003-735c-6ede-3ad0-35519a0e7359@amazon.com>
Date:   Mon, 6 Jul 2020 14:09:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2CpHX9i3YgkNyMHPz63ohjkaSZscMtwSHOFYN4VQow3Q@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D07UWA003.ant.amazon.com (10.43.160.35) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CgpPbiAwMy4wNy4yMCAxMzowNCwgSmFubiBIb3JuIHdyb3RlOgo+IENBVVRJT046IFRoaXMgZW1h
aWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUg
c2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuCj4gCj4gCj4gCj4gT24gRnJpLCBK
dWwgMywgMjAyMCBhdCAxMjozNCBQTSBDYXRhbmdpdSwgQWRyaWFuIENvc3Rpbgo+IDxhY2F0YW5A
YW1hem9uLmNvbT4gd3JvdGU6Cj4+IENyeXB0b2dyYXBoaWMgbGlicmFyaWVzIGNhcnJ5IHBzZXVk
byByYW5kb20gbnVtYmVyIGdlbmVyYXRvcnMgdG8KPj4gcXVpY2tseSBwcm92aWRlIHJhbmRvbW5l
c3Mgd2hlbiBuZWVkZWQuIElmIHN1Y2ggYSByYW5kb20gcG9vbCBnZXRzCj4+IGNsb25lZCwgc2Vj
cmV0cyBtYXkgZ2V0IHJldmVhbGVkLCBhcyB0aGUgc2FtZSByYW5kb20gbnVtYmVyIG1heSBnZXQK
Pj4gdXNlZCBtdWx0aXBsZSB0aW1lcy4gRm9yIGZvcmssIHRoaXMgd2FzIGZpeGVkIHVzaW5nIHRo
ZSBXSVBFT05GT1JLCj4+IG1hZHZpc2UgZmxhZyBbMV0uCj4+Cj4+IFVuZm9ydHVuYXRlbHksIHRo
ZSBzYW1lIHByb2JsZW0gc3VyZmFjZXMgd2hlbiBhIHZpcnR1YWwgbWFjaGluZSBnZXRzCj4+IGNs
b25lZC4gVGhlIGV4aXN0aW5nIGZsYWcgZG9lcyBub3QgaGVscCB0aGVyZS4gVGhpcyBwYXRjaCBp
bnRyb2R1Y2VzIGEKPj4gbmV3IGZsYWcgdG8gYXV0b21hdGljYWxseSBjbGVhciBtZW1vcnkgY29u
dGVudHMgb24gVk0gc3VzcGVuZC9yZXN1bWUsCj4+IHdoaWNoIHdpbGwgYWxsb3cgcmFuZG9tIG51
bWJlciBnZW5lcmF0b3JzIHRvIHJlc2VlZCB3aGVuIHZpcnR1YWwKPj4gbWFjaGluZXMgZ2V0IGNs
b25lZC4KPj4KPj4gRXhhbXBsZXMgb2YgdGhpcyBhcmU6Cj4+ICAgLSBQS0NTIzExIEFQSSByZWlu
aXRpYWxpemF0aW9uIGNoZWNrIChtYW5kYXRlZCBieSBzcGVjaWZpY2F0aW9uKQo+PiAgIC0gZ2xp
YmMncyB1cGNvbWluZyBQUk5HIChyZXNlZWQgYWZ0ZXIgd2FrZSkKPj4gICAtIE9wZW5TU0wgUFJO
RyAocmVzZWVkIGFmdGVyIHdha2UpCj4+Cj4+IEJlbmVmaXRzIGV4aXN0IGluIHR3byBzcGFjZXM6
Cj4+ICAgLSBUaGUgc2VjdXJpdHkgYmVuZWZpdHMgb2YgYSBjbG9uZWQgdmlydHVhbCBtYWNoaW5l
IGhhdmluZyBhCj4+ICAgICByZS1pbml0aWFsaXplZCBQUk5HIGluIGV2ZXJ5IHByb2Nlc3MgYXJl
IHN0cmFpZ2h0Zm9yd2FyZC4KPj4gICAgIFdpdGhvdXQgcmVpbml0aWFsaXphdGlvbiwgdHdvIG9y
IG1vcmUgY2xvbmVkIFZNcyBjb3VsZCBwcm9kdWNlCj4+ICAgICBpZGVudGljYWwgcmFuZG9tIG51
bWJlcnMsIHdoaWNoIGFyZSBvZnRlbiB1c2VkIHRvIGdlbmVyYXRlIHNlY3VyZQo+PiAgICAga2V5
cy4KPj4gICAtIFByb3ZpZGVzIGEgc2ltcGxlIG1lY2hhbmlzbSB0byBhdm9pZCBSQU0gZXhmaWx0
cmF0aW9uIGR1cmluZwo+PiAgICAgdHJhZGl0aW9uYWwgc2xlZXAvaGliZXJuYXRlIG9uIGEgbGFw
dG9wIG9yIGRlc2t0b3Agd2hlbiBtZW1vcnksCj4+ICAgICBhbmQgdGh1cyBzZWNyZXRzLCBhcmUg
dnVsbmVyYWJsZSB0byBvZmZsaW5lIHRhbXBlcmluZyBvciBpbnNwZWN0aW9uLgo+IAo+IEZvciB0
aGUgZmlyc3QgdXNlY2FzZSwgSSB3b25kZXIgd2hpY2ggd2F5IGFyb3VuZCB0aGlzIHdvdWxkIHdv
cmsKPiBiZXR0ZXIgLSBkbyB0aGUgd2lwaW5nIHdoZW4gYSBWTSBpcyBzYXZlZCwgb3IgZG8gaXQg
d2hlbiB0aGUgVk0gaXMKPiByZXN0b3JlZD8gSSBndWVzcyB0aGF0IGF0IGxlYXN0IGluIHNvbWUg
c2NlbmFyaW9zLCBkb2luZyBpdCBvbiByZXN0b3JlCj4gd291bGQgYmUgbmljZXIgYmVjYXVzZSB0
aGF0IHdheSB0aGUgaHlwZXJ2aXNvciBjYW4gYWx3YXlzIGluc3RhbnRseQo+IHNhdmUgYSBWTSB3
aXRob3V0IGhhdmluZyB0byB3YWl0IGZvciB0aGUgZ3Vlc3QgdG8gc2F5ICJhbHJpZ2h0LCBJJ20K
PiByZWFkeSIgLSBlc3BlY2lhbGx5IGlmIHNvbWVvbmUgZS5nLiB3YW50cyB0byB0YWtlIGEgc25h
cHNob3Qgb2YgYQo+IHJ1bm5pbmcgVk0gd2hpbGUga2VlcGluZyBpdCBydW5uaW5nPyBPciBkbyBo
eXBlcnZpc29ycyBpbmplY3Qgc3VjaAo+IEFDUEkgdHJhbnNpdGlvbnMgZXZlcnkgdGltZSB0aGV5
IHNuYXBzaG90L3NhdmUvcmVzdG9yZSBhIFZNIGFueXdheT8KClRvZGF5IGEgaHlwZXJ2aXNvciBz
bmFwc2hvdC9yZXN0b3JlIG9wZXJhdGlvbiBpcyBhbG1vc3QgaW52aXNpYmxlIGZyb20gCnRoZSBW
TSdzIHBvaW50IG9mIHZpZXcuIEknbSBvbmx5IGF3YXJlIG9mIDIgcGxhY2VzIHdoZXJlIGEgbm9y
bWFsIFZNIAp3b3VsZCBiZSBtYWRlIGF3YXJlIG9mIHN1Y2ggYW4gb3BlcmF0aW9uOgoKICAgMSkg
Q2xvY2sgYWRqdXN0bWVudC4gS3ZtY2xvY2sganVtcHMgYWhlYWQgYW5kIHRlbGxzIHlvdSB0aGF0
IGEgbG90IG9mIAp0aW1lIHBhc3NlZAoKICAgMikgVm1HZW5JRC4gVGhlcmUgaXMgYSBzcGVjaWFs
IFBWIGRldmljZSBpbnZlbnRlZCBieSBNUyB0byBpbmRpY2F0ZSAKdG8gYSBWTSBhZnRlciByZXN1
bWUgdGhhdCBpdCdzIGJlZW4gY2xvbmVkLgoKCkkgY2FuIG9ubHkgc3RyZXNzIGFnYWluIHRob3Vn
aCB0aGF0IHRoZSBtYWluIHBvaW50IG9mIHRoaXMgUkZDIGlzIHRvIGdldCAKY29uY2Vuc3VvdXMg
b24gdGhlIHVzZXIgc3BhY2UgQVBJLiBXaGV0aGVyIHdlIHRoZW4gY2xlYXIgb24gVk0gdHJpZ2dl
cmVkIApzdXNwZW5kLCB3ZSBjbGVhciBvbiBoeXBlcnZpc29yIGluZGljYXRlZCByZXN1bWUgb3Ig
d2UgY2xlYXIgYmFzZWQgb24gCnByb3BhZ2F0aW5nIGd1YXJkZWQgcGFnZXMgdG8gdGhlIGh5cGVy
dmlzb3IgaXMgYSBzZXBhcmF0ZSBkaXNjdXNzaW9uIAooQWxzbyB3b3J0aCBoYXZpbmchIEJ1dCBv
cnRob2dvbmFsKS4KCj4gCj4+IFRoaXMgUkZDIGlzIGZvcmVtb3N0IGFpbWVkIGF0IGRlZmluaW5n
IGEgdXNlcnNwYWNlIGludGVyZmFjZSB0byBlbmFibGUKPj4gYXBwbGljYXRpb25zIGFuZCBsaWJy
YXJpZXMgdGhhdCBzdG9yZSBvciBjYWNoZSBzZW5zaXRpdmUgaW5mb3JtYXRpb24sCj4+IHRvIGtu
b3cgdGhhdCB0aGV5IG5lZWQgdG8gcmVnZW5lcmF0ZSBpdCBhZnRlciBwcm9jZXNzIG1lbW9yeSBo
YXMgYmVlbgo+PiBleHBvc2VkIHRvIHBvdGVudGlhbCBjb3B5aW5nLiAgVGhlIHByb3Bvc2VkIHVz
ZXJzcGFjZSBpbnRlcmZhY2UgaXMKPj4gYSBuZXcgTUFEVl9XSVBFT05TVVNQRU5EICdtYWR2aXNl
KCknIGZsYWcgdXNlZCB0byBtYXJrIHBhZ2VzIHdoaWNoCj4+IGNvbnRhaW4gc3VjaCBkYXRhLiBU
aGlzIG5ld2x5IGFkZGVkIGZsYWcgd291bGQgb25seSBiZSBhdmFpbGFibGUgb24KPj4gNjRiaXQg
YXJjaHMsIHNpbmNlIHdlJ3ZlIHJ1biBvdXQgb2YgMzJiaXQgVk1BIGZsYWdzLgo+Pgo+PiBUaGUg
bWVjaGFuaXNtIHRocm91Z2ggd2hpY2ggdGhlIGtlcm5lbCBtYXJrcyB0aGUgYXBwbGljYXRpb24g
c2Vuc2l0aXZlCj4+IGRhdGEgYXMgcG90ZW50aWFsbHkgY29waWVkLCBpcyBhIHNlY29uZGFyeSBv
YmplY3RpdmUgb2YgdGhpcyBSRkMuIEluCj4+IHRoZSBjdXJyZW50IFBvQyBwcm9wb3NhbCwgdGhl
IFJGQyBrZXJuZWwgY29kZSBjb21iaW5lcwo+PiBNQURWX1dJUEVPTlNVU1BFTkQgc2VtYW50aWNz
IHdpdGggQUNQSSBzdXNwZW5kL3dha2UgdHJhbnNpdGlvbnMgdG8gemVybwo+PiBvdXQgYWxsIHBy
b2Nlc3MgcGFnZXMgdGhhdCBmYWxsIGluIFZNQXMgbWFya2VkIGFzIE1BRFZfV0lQRU9OU1VTUEVO
RAo+PiBhbmQgdGh1cyBhbGxvdyBhcHBsaWNhdGlvbnMgYW5kIGxpYnJhcmllcyBiZSBub3RpZmll
ZCBhbmQgcmVnZW5lcmF0ZQo+PiB0aGVpciBzZW5zaXRpdmUgZGF0YS4gIE1hcmtpbmcgVk1BcyBh
cyBNQURWX1dJUEVPTlNVU1BFTkQgcmVzdWx0cyBpbgo+PiB0aGUgVk1BcyBiZWluZyBlbXB0eSBp
biB0aGUgcHJvY2VzcyBhZnRlciBhbnkgc3VzcGVuZC93YWtlIGN5Y2xlLgo+PiBTaW1pbGFyIHRv
IE1BRFZfV0lQRU9ORk9SSywgaWYgdGhlIHByb2Nlc3MgYWNjZXNzZXMgbWVtb3J5IHRoYXQgd2Fz
Cj4+IHdpcGVkIG9uIHN1c3BlbmQsIGl0IHdpbGwgZ2V0IHplcm9lcy4gIFRoZSBhZGRyZXNzIHJh
bmdlcyBhcmUgc3RpbGwKPj4gdmFsaWQsIHRoZXkgYXJlIGp1c3QgZW1wdHkuCj4+Cj4+IFRoaXMg
cGF0Y2ggYWRkcyBsb2dpYyB0byB0aGUga2VybmVsIHBvd2VyIGNvZGUgdG8gemVybyBvdXQgY29u
dGVudHMgb2YKPj4gYWxsIE1BRFZfV0lQRU9OU1VTUEVORCBWTUFzIHByZXNlbnQgaW4gdGhlIHN5
c3RlbSBkdXJpbmcgaXRzIHRyYW5zaXRpb24KPj4gdG8gYW55IHN1c3BlbmQgc3RhdGUgZXF1YWwg
b3IgZ3JlYXRlci9kZWVwZXIgdGhhbiBTdXNwZW5kLXRvLW1lbW9yeSwKPj4ga25vd24gYXMgUzMu
Cj4+Cj4+IE1BRFZfV0lQRU9OU1VTUEVORCBvbmx5IHdvcmtzIG9uIHByaXZhdGUsIGFub255bW91
cyBtYXBwaW5ncy4KPj4gVGhlIHBhdGNoIGFsc28gYWRkcyBNQURWX0tFRVBPTlNVU1BFTkQsIHRv
IHVuZG8gdGhlIGVmZmVjdHMgb2YgYQo+PiBwcmlvciBNQURWX1dJUEVPTlNVU1BFTkQgZm9yIGEg
Vk1BLgo+Pgo+PiBIeXBlcnZpc29ycyBjYW4gaXNzdWUgQUNQSSBTMC0+UzMgYW5kIFMzLT5TMCBl
dmVudHMgdG8gbGV2ZXJhZ2UgdGhpcwo+PiBmdW5jdGlvbmFsaXR5IGluIGEgdmlydHVhbGl6ZWQg
ZW52aXJvbm1lbnQuCj4+Cj4+IEFsdGVybmF0aXZlIGtlcm5lbCBpbXBsZW1lbnRhdGlvbiBpZGVh
czoKPj4gICAtIE1vdmUgdGhlIGNvZGUgdGhhdCBjbGVhcnMgTUFEVl9XSVBFT05GT1JLIHBhZ2Vz
IHRvIGEgdmlydHVhbAo+PiAgICAgZGV2aWNlIGRyaXZlciB0aGF0IHJlZ2lzdGVycyBpdHNlbGYg
dG8gQUNQSSBldmVudHMuCj4+ICAgLSBBZGQgcHJlcmVxdWlzaXRlIHRoYXQgTUFEVl9XSVBFT05G
T1JLIHBhZ2VzIG11c3QgYmUgcGlubmVkIChzbwo+PiAgICAgbm8gZmF1bHRpbmcgaGFwcGVucykg
YW5kIGNsZWFyIHRoZW0gaW4gYSBjdXN0b20vcm9sbC15b3VyLW93bgo+PiAgICAgZGV2aWNlIGRy
aXZlciBvbiBhIE5NSSBoYW5kbGVyLiBUaGlzIGNvdWxkIHdvcmsgaW4gYSB2aXJ0dWFsaXplZAo+
PiAgICAgZW52aXJvbm1lbnQgd2hlcmUgdGhlIGh5cGVydmlzb3IgcGF1c2VzIGFsbCBvdGhlciB2
Q1BVcyBiZWZvcmUKPj4gICAgIGluamVjdGluZyB0aGUgTk1JLgo+Pgo+PiBbMV0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC8yMDE3MDgxMTIxMjgyOS4yOTE4Ni0xLXJpZWxAcmVkaGF0LmNv
bS8KPiBbLi4uXQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3Bvd2VyL3N1c3BlbmQuYyBiL2tlcm5l
bC9wb3dlci9zdXNwZW5kLmMKPj4gaW5kZXggYzg3NGE3MDI2ZTI0Li40MjgyYjdmMGRkMDMgMTAw
NjQ0Cj4+IC0tLSBhL2tlcm5lbC9wb3dlci9zdXNwZW5kLmMKPj4gKysrIGIva2VybmVsL3Bvd2Vy
L3N1c3BlbmQuYwo+PiBAQCAtMzIzLDYgKzMyMyw3OCBAQCBzdGF0aWMgYm9vbCBwbGF0Zm9ybV9z
dXNwZW5kX2FnYWluKHN1c3BlbmRfc3RhdGVfdCBzdGF0ZSkKPj4gICAgICAgICAgICAgICAgICBz
dXNwZW5kX29wcy0+c3VzcGVuZF9hZ2FpbigpIDogZmFsc2U7Cj4+ICAgfQo+Pgo+PiArI2lmZGVm
IFZNX1dJUEVPTlNVU1BFTkQKPj4gK3N0YXRpYyB2b2lkIG1lbW9yeV9jbGVhbnVwX29uX3N1c3Bl
bmQoc3VzcGVuZF9zdGF0ZV90IHN0YXRlKQo+PiArewo+PiArICAgICAgIHN0cnVjdCB0YXNrX3N0
cnVjdCAqcDsKPj4gKyAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICptbTsKPj4gKyAgICAgICBzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYTsKPj4gKyAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZXNbMzJd
Owo+PiArICAgICAgIHVuc2lnbmVkIGxvbmcgbWF4X3BhZ2VzX3Blcl9sb29wID0gQVJSQVlfU0la
RShwYWdlcyk7Cj4+ICsKPj4gKyAgICAgICAvKiBPbmx5IGNhcmUgYWJvdXQgc3RhdGVzID49IFMz
ICovCj4+ICsgICAgICAgaWYgKHN0YXRlIDwgUE1fU1VTUEVORF9NRU0pCj4+ICsgICAgICAgICAg
ICAgICByZXR1cm47Cj4+ICsKPj4gKyAgICAgICByY3VfcmVhZF9sb2NrKCk7Cj4+ICsgICAgICAg
Zm9yX2VhY2hfcHJvY2VzcyhwKSB7Cj4+ICsgICAgICAgICAgICAgICBpbnQgZ3VwX2ZsYWdzID0g
Rk9MTF9XUklURTsKPj4gKwo+PiArICAgICAgICAgICAgICAgbW0gPSBwLT5tbTsKPj4gKyAgICAg
ICAgICAgICAgIGlmICghbW0pCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+
PiArCj4+ICsgICAgICAgICAgICAgICBkb3duX3JlYWQoJm1tLT5tbWFwX3NlbSk7Cj4gCj4gQmxv
Y2tpbmcgYWN0aW9ucywgc3VjaCBhcyBsb2NraW5nIHNlbWFwaG9yZXMsIGFyZSBmb3JiaWRkZW4g
aW4gUkNVCj4gcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb25zLiBBbHNvLCBmcm9tIGEgbW9yZSBo
aWdoLWxldmVsIHBlcnNwZWN0aXZlLAo+IGRvIHdlIG5lZWQgdG8gYmUgY2FyZWZ1bCBoZXJlIHRv
IGF2b2lkIGRlYWRsb2NrcyB3aXRoIGZyb3plbiB0YXNrcyBvcgo+IHN0dWZmIGxpa2UgdGhhdD8K
CkNhbiB5b3UgdGhpbmsgb2YgYSBiZXR0ZXIgYWx0ZXJuYXRpdmU/Cgo+IAo+PiArICAgICAgICAg
ICAgICAgZm9yICh2bWEgPSBtbS0+bW1hcDsgdm1hOyB2bWEgPSB2bWEtPnZtX25leHQpIHsKPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBhZGRyLCBucl9wYWdlczsKPj4g
Kwo+PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoISh2bWEtPnZtX2ZsYWdzICYgVk1fV0lQ
RU9OU1VTUEVORCkpCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7
Cj4+ICsKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgYWRkciA9IHZtYS0+dm1fc3RhcnQ7Cj4+
ICsgICAgICAgICAgICAgICAgICAgICAgIG5yX3BhZ2VzID0gKHZtYS0+dm1fZW5kIC0gYWRkciAt
IDEpIC8gUEFHRV9TSVpFICsgMTsKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgd2hpbGUgKG5y
X3BhZ2VzKSB7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGNvdW50ID0g
bWluKG5yX3BhZ2VzLCBtYXhfcGFnZXNfcGVyX2xvb3ApOwo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZvaWQgKmthZGRyOwo+PiArCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY291bnQgPSBnZXRfdXNlcl9wYWdlc19yZW1vdGUocCwgbW0sIGFkZHIsCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY291
bnQsIGd1cF9mbGFncywKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwYWdlcywgTlVMTCwgTlVMTCk7Cj4gCj4gZ2V0X3VzZXJfcGFnZXNf
cmVtb3RlKCkgY2FuIHdhaXQgZm9yIGRpc2sgSS9PIChmb3Igc3dhcHBpbmcgc3R1ZmYgYmFjawo+
IGluKSwgd2hpY2ggd2UnZCBwcm9iYWJseSBsaWtlIHRvIGF2b2lkIGhlcmUuIEFuZCBJIHRoaW5r
IGl0IGNhbiBhbHNvCj4gd2FpdCBmb3IgdXNlcmZhdWx0ZmQgaGFuZGxpbmcgZnJvbSB1c2Vyc3Bh
Y2U/IHphcF9wYWdlX3JhbmdlKCkgKHdoaWNoCj4gaXMgd2hhdCBlLmcuIE1BRFZfRE9OVE5FRUQg
dXNlcykgbWlnaHQgYmUgYSBiZXR0ZXIgZml0LCBzaW5jZSBpdCBjYW4KPiB5YW5rIGVudHJpZXMg
b3V0IG9mIHRoZSBwYWdlIHRhYmxlIChmb3JjaW5nIHRoZSBuZXh0IHdyaXRlIGZhdWx0IHRvCj4g
YWxsb2NhdGUgYSBuZXcgemVyb2VkIHBhZ2UpIHdpdGhvdXQgZmF1bHRpbmcgdGhlbSBpbnRvIFJB
TS4KClRoYXQgc291bmRzIGxpa2UgYSBtdWNoIGJldHRlciBmaXQgaW5kZWVkLCB0aGFua3MhCgoK
QWxleAoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3Ry
LiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2Vy
LCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVy
ZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkK
Cgo=

