Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78B11E9FBD
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgFAID0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 04:03:26 -0400
Received: from mout.web.de ([212.227.15.3]:44635 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgFAIDZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Jun 2020 04:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590998490;
        bh=ZlwBKtweFinmq9oliJrZpcxljKh4XBTXsF6fEwesa48=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=KYurXaxho/eQPs30owD64GnhJ5z485nZkg1Fk39kWI5kb2lg21UmyaQVq5pJYSKF1
         XK1pSTNEANFD07iKBSot4Db5wh6apCNRtxIZWLH+4BXE8H6EcYBe2V0iWHK9PaB8YP
         7SvpydSyJ01FUmeyB/kyJEbdRGF7XVS2GFSmI+4U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LZeou-1jGCTE1a8q-00lU4b; Mon, 01
 Jun 2020 10:01:28 +0200
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-pm@vger.kernel.org
Cc:     Navid Emamdoost <emamd001@umn.edu>, linux-kernel@vger.kernel.org,
        Kangjie Lu <kjlu@umn.edu>, Qiushi Wu <wu000273@umn.edu>,
        Stephen McCamant <mccamant@cs.umn.edu>,
        Sebastian Reichel <sre@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] power: supply: bq24190_charger.c: call pm_runtime_put in
 pm_runtime_get_sync failed case
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <35c8ecf5-c3d0-33a5-3bb5-f8dbbe88647c@web.de>
Date:   Mon, 1 Jun 2020 10:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:11YJJFoQnbazHD+6k1HYpgimgzcX9EmkM0bGG5cBium5S+86N2Z
 pCXrjDmNUJ1sUoqUYMnC7zikW4I+eDRwu0u/UsJXMeRiDsVOv5uqdDNW2/lIYvWzv6puxpK
 BxjWwe3YUevd+FuCfmp8JLjshjGN59TUiEGj1WRF4xK+RWRbpd096CdHhrbHm8x8XjNeX+l
 tpYFrjkT/I49Fq0o7X+Ow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gkBWRR2FBJo=:ahFVCwKuKd6ikqLE3VOysR
 0pxOfOyRa+nQKLHryxJoXy1R1x1SOdnBndGKZrJda9ISzKkou0VxTLpnzerCQwQ8TMZ73XfR0
 XgK+XxtQi+I54j+hOIaol9Rct0mSJMENEhw9I4EpvdjKGptwe7zrqlVBNKfVqRAQ88YQ+ci2v
 KH8wgBHW5QyBYT/0lT51OG4B8JndGU+6Exe83CDiHExVTM/2GdKaNty5lXN+F4OkfElsHVpPE
 bp50FPPE9wvtouTpJ880UxfwfK+K+fWK4247Z47oNAeL3Nn9RZt4WE0xgxZBuBTOKZyXlwugX
 JlVG+Alt7cK2K/D4O3YOR5GRCf++vwjt4zBDsN4vxt0StmeKP4gKGU+6bBV9VM33RG0qKXV/Y
 CNBaEgEYq5vCYStzItFe59qZY07bfafOL0E34VvIJ1pdb8QUAVRddXu4ZZAEPHOoALTayoaMb
 4134o7VJZ1DbsISzXOjX5GyMkdTHzKrBMh1iIABv9CP/pnk1ZU/DPnJKxMUWf5s+E2/qnxgi2
 hD1MFyIuZI7VJFoIB84X4y/sbGZHp1bDJx3h7auKEK3I/9YPOWM1NX4KIIbCA/3OCBKU4pHhI
 qVI1Ajj9ZOXivH3JbpSQmZxP0SXA2Xc6kaDibq7BANzO5Qah0fADIiltSY9NbmVD19i/nmJAG
 F+RCPS8Qor8nVSBondEH1PV6dmUn233e90OSi6o36bba1yz7/A1t2D592noQdt558jxyc5KxB
 EU1sENRTR2AteRZ0Mqd/HHXRv225RM9vjMbxd6FelIJcLtGDgKTdB4ARwVTNlMEQfauXdlG5J
 SV3xmrg19ZpYrBPZ9L/Hp7KnvUWq8kKceVqw8ZlcDG4qBRRr+DlUFOyyjGppo7ZY/GG/hm28a
 5RbZGPSFPSEb58bAGeT6DwL9B/qqF44Ir4JiuPJF+LKmv1vGzsPxXl/zlJuqTn5ORCLAWI01u
 sN6FJAGQz/puLDSSKvgCSe/NAh8ShyhXL5TlPtP0w5b++LDdQQQlc29/gaGKpi6bCLaPzgy0F
 VnZrklBQP2vTtLnsdo21HL6QUYBtIEVHeUO9B8aravFVWBOhcEowikgkQnRuimYUa/monIWvp
 DA5j9PlVVGcemrwTDYI6LbPTTIvgSz6stPbCIOw7Y5Xlr/HIv6Wz2D7LvwtXuiQytPVn/xzOO
 7eIYyJTsF0IhB24AEoTOwLvYDadqqj5/gFIfIK8e+T6f0z/g5UeCDyTHl2a9f45YO0xlny5Kg
 Urel8Wl4UDJfKx2kd
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Even in failed case of pm_runtime_get_sync, the usage_count
> is incremented. In order to keep the usage_count with correct
> value call pm_runtime_put_autosuspend.

* I find the word =E2=80=9Cusage_count=E2=80=9D questionable in this chang=
e description.

* Will the tag =E2=80=9CFixes=E2=80=9D become relevant for the commit mess=
age?

* Can an other label be more helpful than =E2=80=9Cout=E2=80=9D?

* Would you like to take another look at a related update suggestion
  like =E2=80=9Cpower: supply: bq24190_charger: Fix runtime PM imbalance o=
n error=E2=80=9D?
  https://lore.kernel.org/linux-pm/20200525110540.6949-1-dinghao.liu@zju.e=
du.cn/
  https://lore.kernel.org/patchwork/patch/1246783/

Regards,
Markus
