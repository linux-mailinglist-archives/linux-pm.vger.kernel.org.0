Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A001F17E4
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 13:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgFHLe2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 07:34:28 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:5402 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729310AbgFHLe2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 07:34:28 -0400
X-IronPort-AV: E=Sophos;i="5.73,487,1583190000"; 
   d="scan'208";a="453527699"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 13:34:25 +0200
Date:   Mon, 8 Jun 2020 13:34:25 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Joe Perches <joe@perches.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        Dan Carpenter <error27@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kernel: power: swap: mark a function as __init to save
 some memory
In-Reply-To: <20200608112228.GW30374@kadam>
Message-ID: <alpine.DEB.2.21.2006081329570.3136@hadrien>
References: <20200531210059.647066-1-christophe.jaillet@wanadoo.fr> <effe3cde7b1f188427c42c476f5a96251d837416.camel@perches.com> <20200608112228.GW30374@kadam>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1740847280-1591616066=:3136"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1740847280-1591616066=:3136
Content-Type: text/plain; charset=US-ASCII



On Mon, 8 Jun 2020, Dan Carpenter wrote:

> On Sun, May 31, 2020 at 03:11:27PM -0700, Joe Perches wrote:
> > (adding Dan Carpenter)
> >
> > On Sun, 2020-05-31 at 23:00 +0200, Christophe JAILLET wrote:
> > > 'swsusp_header_init()' is only called via 'core_initcall'.
> > > It can be marked as __init to save a few bytes of memory.
> >
> > Hey Dan
> >
> > smatch has a full function calling tree right?
> >
> > Can smatch find unmarked functions called only by __init
> > functions so those unmarked functions can be appropriately
> > marked with __init like the below?
> >
>
> It turns out it's complicated to do this in Smatch because Sparse
> ignores the section attribute.  :/

I wrote a script at one point for this for Coccinelle, and sent some
patches.  It requires some effort, because you want to run it over and
over - once function Y becomes init, some other functions might become
init as well.  The iteration could be done automatically with Coccinelle,
but I didn't take that option, because it semed safer to check the results
along the way.  A version of the script is attached.

julia
--8323329-1740847280-1591616066=:3136
Content-Type: text/plain; charset=US-ASCII; name=useful_inits3.cocci
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2006081334250.3136@hadrien>
Content-Description: 
Content-Disposition: attachment; filename=useful_inits3.cocci

Ly8gTm8gaXRlcmF0aW9uLiAgRG8gaXQgYnkgaGFuZC4NCg0KQGluaXRpYWxp
emU6b2NhbWxADQpAQA0KDQpsZXQgaXRibCA9IEhhc2h0YmwuY3JlYXRlIDEw
MQ0KbGV0IGx0YmwgPSBIYXNodGJsLmNyZWF0ZSAxMDENCmxldCB0aGVmaWxl
ID0gcmVmICIiDQoNCmxldCBoYXNoYWRkIHQgayA9DQogIGxldCBjZWxsID0N
CiAgICB0cnkgSGFzaHRibC5maW5kIHQgaw0KICAgIHdpdGggTm90X2ZvdW5k
IC0+DQogICAgICBsZXQgY2VsbCA9IHJlZiAwIGluDQogICAgICBIYXNodGJs
LmFkZCB0IGsgY2VsbDsNCiAgICAgIGNlbGwgaW4NCiAgY2VsbCA6PSAhY2Vs
bCArIDENCg0KbGV0IGhhc2hnZXQgdCBrID0gdHJ5ICEoSGFzaHRibC5maW5k
IHQgaykgd2l0aCBOb3RfZm91bmQgLT4gMA0KDQpsZXQgc2VlbiAgPSByZWYg
W10NCg0KQHNjcmlwdDpvY2FtbEANCkBADQoNCihsZXQgZmlsZSA9IExpc3Qu
aGQgKENvY2NpbGliLmZpbGVzKCkpIGluDQp0aGVmaWxlIDo9IGZpbGU7DQps
ZXQgZmlsZSA9DQogICAgdHJ5IExpc3QuaGQoTGlzdC50bCAoU3RyLnNwbGl0
IChTdHIucmVnZXhwICIvbGludXgtbmV4dC8iKSBmaWxlKSkNCiAgICB3aXRo
IF8gLT4gZmlsZSBpbg0KbGV0IG9maWxlID0gIi92YXIvanVsaWEvbGludXgt
bmV4dC8iIF4NCiAgICAgIChGaWxlbmFtZS5jaG9wX2V4dGVuc2lvbiBmaWxl
KSBeICIubyIgaW4NCmlmIG5vdChTeXMuZmlsZV9leGlzdHMgb2ZpbGUpDQp0
aGVuIENvY2NpbGliLmV4aXQoKSk7DQoNCkhhc2h0YmwuY2xlYXIgaXRibDsN
Ckhhc2h0YmwuY2xlYXIgbHRibDsNCnNlZW4gOj0gW10NCg0KQHJADQppZGVu
dGlmaWVyIGY7DQpAQA0KDQpfX2luaXQgZiguLi4pIHsgLi4uIH0NCg0KQHNj
cmlwdDpvY2FtbEANCmYgPDwgci5mOw0KQEANCg0KSGFzaHRibC5hZGQgaXRi
bCBmICgpDQoNCkBzIGRpc2FibGUgb3B0aW9uYWxfYXR0cmlidXRlc0ANCmlk
ZW50aWZpZXIgZjsNCkBADQoNCnN0YXRpYyBmKC4uLikgeyAuLi4gfQ0KDQpA
c2NyaXB0Om9jYW1sQA0KZiA8PCBzLmY7DQpAQA0KDQpIYXNodGJsLmFkZCBs
dGJsIGYgKCkNCg0KQHQgZXhpc3RzQA0KaWRlbnRpZmllciBmLGc7DQpwb3Np
dGlvbiBwOw0KQEANCg0KX19pbml0IGYoLi4uKSB7IC4uLiB3aGVuIGFueQ0K
ICAgZ0BwKC4uLikNCiAgIC4uLiB3aGVuIGFueQ0KIH0NCg0KQHNjcmlwdDpv
Y2FtbEANCmcgPDwgdC5nOw0KX3AgPDwgdC5wOw0KQEANCg0KaWYgbm90IChI
YXNodGJsLm1lbSBsdGJsIGcpIHx8IEhhc2h0YmwubWVtIGl0YmwgZw0KdGhl
biBDb2NjaWxpYi5pbmNsdWRlX21hdGNoIGZhbHNlDQoNCkBvazEgZGlzYWJs
ZSBvcHRpb25hbF9hdHRyaWJ1dGVzIGV4aXN0c0ANCmlkZW50aWZpZXIgZix0
Lmc7DQpAQA0KDQpmKC4uLikgeyAuLi4gd2hlbiBhbnkNCiAgIGcNCiAgIC4u
LiB3aGVuIGFueQ0KIH0NCg0KQG9rMiBkaXNhYmxlIG9wdGlvbmFsX2F0dHJp
YnV0ZXMgZXhpc3RzQA0KaWRlbnRpZmllciBpLGosZmxkLHQuZzsNCkBADQoN
CnN0cnVjdCBpIGogPSB7IC5mbGQgPSBnLCB9Ow0KDQpAb2szIGRpc2FibGUg
b3B0aW9uYWxfYXR0cmlidXRlcyBleGlzdHNADQppZGVudGlmaWVyIHQuZzsN
CmRlY2xhcmVyIGQ7DQpAQA0KDQpkKC4uLixnLC4uLik7DQoNCkBvazQgZGlz
YWJsZSBvcHRpb25hbF9hdHRyaWJ1dGVzIGV4aXN0c0ANCmlkZW50aWZpZXIg
dC5nOw0KZXhwcmVzc2lvbiBlOw0KQEANCg0KKA0KZSguLi4sZywuLi4pDQp8
DQplKC4uLiwmZywuLi4pDQp8DQplID0gJmcNCnwNCmUgPSBnDQopDQoNCkBz
Y3JpcHQ6b2NhbWwgZGVwZW5kcyBvbiAhb2sxICYmICFvazIgJiYgIW9rMyAm
JiAhb2s0QA0KZyA8PCB0Lmc7DQpAQA0KDQpsZXQgZmlsZSA9ICF0aGVmaWxl
IGluDQpsZXQgZmlsZSA9DQogICAgdHJ5IExpc3QuaGQoTGlzdC50bCAoU3Ry
LnNwbGl0IChTdHIucmVnZXhwICIvbGludXgtbmV4dC8iKSBmaWxlKSkNCiAg
ICB3aXRoIF8gLT4gZmlsZSBpbg0KaWYgbm90KExpc3QubWVtIChnLGZpbGUp
ICFzZWVuKQ0KdGhlbg0KICBiZWdpbg0KICAgIHNlZW4gOj0gKGcsZmlsZSkg
OjogIXNlZW47DQogICAgbGV0IG9maWxlID0gIi92YXIvanVsaWEvbGludXgt
bmV4dC8iIF4NCiAgICAgIChGaWxlbmFtZS5jaG9wX2V4dGVuc2lvbiBmaWxl
KSBeICIubyIgaW4NCiAgICBpZiBTeXMuZmlsZV9leGlzdHMgb2ZpbGUNCiAg
ICB0aGVuDQogICAgICBsZXQgbCA9DQoJQ29tbW9uLmNtZF90b19saXN0DQoJ
ICAoUHJpbnRmLnNwcmludGYNCgkgICAgICJvYmpkdW1wIC14ICVzIHwgZ3Jl
cCAtdyAlcyB8IGdyZXAgLXcgRiB8IGdyZXAgLnRleHQudW5saWtlbHkiDQoJ
ICAgICBvZmlsZSBnKSBpbg0KICAgICAgbWF0Y2ggbCB3aXRoDQoJW10gLT4g
Q29jY2lsaWIuaW5jbHVkZV9tYXRjaCBmYWxzZQ0KICAgICAgfCBfIC0+DQoJ
ICBQcmludGYucHJpbnRmICJJbmZvIGZvciAlcyAlc1xuIiBmaWxlIGc7DQoJ
ICBMaXN0Lml0ZXINCgkgICAgKGZ1bmN0aW9uIGwgLT4gUHJpbnRmLnByaW50
ZiAiJXNcbiIgbCkNCgkgICAgbDsNCgkgIFByaW50Zi5wcmludGYgIlxuIjsg
Zmx1c2ggc3Rkb3V0DQogICAgZWxzZSBDb2NjaWxpYi5pbmNsdWRlX21hdGNo
IGZhbHNlDQogIGVuZA0KZWxzZSBDb2NjaWxpYi5pbmNsdWRlX21hdGNoIGZh
bHNlDQoNCkBkZXBlbmRzIG9uICFvazEgJiYgIW9rMiAmJiAhb2szICYmICFv
azRADQppZGVudGlmaWVyIHQuZzsNCkBADQoNCi0gZw0KK19faW5pdCBnDQog
KC4uLikgeyAuLi4gfQ0K

--8323329-1740847280-1591616066=:3136--
