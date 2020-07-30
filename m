Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BF82337DD
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 19:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgG3RqL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 13:46:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:58555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbgG3RqJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 13:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596131147;
        bh=ziofVbDPyMepDQRodxoTHDhSQkTSPPyJObV8bPWtPoc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fH711ZLa5yEYsTCTWeFrln+WvXr/VXqbuUycuwO0XjwX71U00TTppsVtMHeROOG++
         zfVX81gvlx4mAw3NAcPFBhfqBdcP17CQhdDgPAzpNY+AV7gnPGQPEoJTUP5aX4/lvu
         GweeHWyiPGA7x5jsZ/XbvSn4UH7YkcNDdXppoV4M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.153.170] ([217.61.153.170]) by web-mail.gmx.net
 (3c-app-gmx-bs42.server.lan [172.19.170.94]) (via HTTP); Thu, 30 Jul 2020
 19:45:47 +0200
MIME-Version: 1.0
Message-ID: <trinity-a82d184c-1a5a-4f73-84c7-bcba3d84d5a4-1596131147519@3c-app-gmx-bs42>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Henry Yen <henry.yen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Steven Liu <steven.liu@mediatek.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Kao <michael.kao@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re: [PATCH v2 2/2] thermal: mediatek: add tsensor support for
 V2 thermal system
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 30 Jul 2020 19:45:47 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <f086c86e-7d7b-50c4-baf2-66022301adc7@gmail.com>
References: <1588238074-19338-1-git-send-email-henry.yen@mediatek.com>
 <1588238074-19338-3-git-send-email-henry.yen@mediatek.com>
 <f086c86e-7d7b-50c4-baf2-66022301adc7@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:liEgXdZdQEfY6Ky+bUEyDmAT1l8rflGstgulqOOUFiRvZcT6loE54dXlbJwLoDoyIc4g5
 vTvgx3nVh3S03USdfmrNBoec5RdFtdV9A0f9GXX0v6DuJLO2+4sqxHpj6cynSIQaSjT3k29PNGUl
 VzLSKNbEfveLsG6ZyyMENtHut9R9JJRTxbwV85w/qWMt8cHGEzEz6YFxOoIMrYHNOCk2jPsY6Sp0
 6lP/UikkBy/MRa06x1XDzIN3Sg2w/NTSPkcTy6JvAcWnYSsEbHgjsRc8vYP2gbuMYecbQADjyM7/
 Pg=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nh16j63B6Fc=:9dUhrUCU5ImqnaLk3ZqnDa
 tqQhdXvW3JKWxKIb5COUQg5r6Z422Ol2r4/D+G5+w4jnjtHC0dYi/WkaP9aEV63ZDkllKM88S
 uYk+XZ3NyXds0YmShldyjOVzVlQTHjsbmms50Md7Ycv/8tTgQoFtij6UGhPrRN/I944ycX1hK
 QNd7dURf7xsCkckCVqao0lqfL+wnLOuIjKTJvCv2H+tRF5WT5XFsGtUBB+QKZkPpZHMbuwGZo
 MPCDXTkjT1QlGbRD20MwlXlEXT8MCTlHueuTSFGHAhJ6ahIbrpUC0DI2iWewfhYXwL9QEtJkb
 cfb0XFy0wn23U7rUYwm61T+EDLJ6VcXIRL1oyHeH/naNjLeC29Gavyf6gP48ZdlM9tb1NQ8pn
 PhHiWgHPZtl9OICAOcp//iviyqMvHCsPOjT12GQUID3s3W+3U88+Fz+bwr02D8FyszIKwaEWm
 YxLgOlTwzosJm3x2Y3NuutHTmuPEppTMSid4pOiABElQWZdWBKQbhwWUIfWHqHv9ilRC9VUyB
 CPF/LZpjMQcTCjE3jWRpqsTwwCI19LfgYe+YE50xpsta/oWUo+82KWdeWUJHdG4kbXUoWrm3v
 PhMT/dQccX4/AZqfU7yEY0/qHC9oTnTzJ/vwczAix/ad2iT8tHDpAp+b8nAwFpgOgu2vrcVuW
 VrUebNPHa+omjSdODq9RRLj6Z2oJkcPmxYi7mxOrZkrUCcwEZkzltOAP/ckVWRfsFwB0=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tested on bpi-r64 and r2, i hope this can be merged to next / 5.9

Tested-By: Frank Wunderlich <frank-w@public-files.de>

regards Frank
