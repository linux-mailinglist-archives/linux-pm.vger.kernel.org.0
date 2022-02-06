Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B334AAE98
	for <lists+linux-pm@lfdr.de>; Sun,  6 Feb 2022 10:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiBFJcQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Feb 2022 04:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiBFJcP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Feb 2022 04:32:15 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3151C06173B
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 01:32:14 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,347,1635199200"; 
   d="scan'208";a="19916938"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 10:32:12 +0100
Date:   Sun, 6 Feb 2022 10:32:12 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Zhang Rui <rui.zhang@intel.com>
cc:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: DRAM power consumption with turbostat
In-Reply-To: <44a1ea665bad28a8e2d314427d9c50c214e1a436.camel@intel.com>
Message-ID: <alpine.DEB.2.22.394.2202061002430.3126@hadrien>
References: <alpine.DEB.2.22.394.2201301121380.3109@hadrien> <44a1ea665bad28a8e2d314427d9c50c214e1a436.camel@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Sun, 6 Feb 2022, Zhang Rui wrote:

> Hi, Julia,
>
> Thanks for reporting this.
>
> On Sun, 2022-01-30 at 11:27 +0100, Julia Lawall wrote:
> > Hello,
> >
> > I was wondering whether the DRAM power consumption reported by
> > turbostat
> > is reliable on recent Intel machines?
> >
> > In particular, I observed that turbostat reported a high DRAM energy
> > comsumption on a machine (Intel 5128)
>
> are you sure it is 5128? google tells me that 5128 is pretty old, in
> around 2006.
>
> can you please paste the lscpu output?
>
> >  with persistent memory, but where
> > the persistent memory was not being used.  A colleague did an
> > experiemnt
> > on another machine with persistent memory, and reported:
> >
> > -----
> >
> > I didn't run the test on troll but on another server equipped with PM
> > where I was able to reproduce the bug and by reading directly the msr
> > registers, I see that:
> > CPU Energy units = 0.00006104J
> > DRAM Energy units = 0.00001526J
> >
> > However turbostat assumes that the DRAM  Energy units is 0.00006104J
> > when
> > it runs the computation to obtain Joules (hence the too-high value
> > returned by turbostat)
>
> And can you please try latest version of turbostat?
>
> The problem should be fixed by the below commit

The result indeed looks better, thanks!

The following just spins one on core for 5 seconds:

root@troll-4:/home/jlawall/spin# turbostat --version
turbostat version 20.09.30 - Len Brown <lenb@kernel.org>
root@troll-4:/home/jlawall/spin# head troll_turbo
5.011506 sec
Package	Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IRQ	SMI	POLL	C1	C1E	C6	POLL%	C1%	C1E%	C6%	CPU%c1	CPU%c6	CoreTmp	PkgTmp	Pkg%pc2	Pkg%pc6	Pkg_J	RAM_J	PKG_%	RAM_%
-	-	-	61	1.59	3853	2294	5176	0	37	1493	153	2853	0.00	0.22	0.03	98.14	2.73	95.68	38	40	39.42	0.00	459.78	1336.73	0.00	0.00
0	0	0	4	0.36	1107	2294	298	0	0	0	0	564	0.00	0.00	0.00	99.69	4.86	94.78	36	40	78.85	0.00	228.32	664.98	0.00	0.00
0	0	32	1	0.06	1263	2294	49	0	0	1	14	46	0.00	0.00	0.69	99.26	5.15
0	1	4	0	0.03	1395	2294	29	0	0	8	0	44	0.00	0.59	0.00	99.36	1.03	98.94	34
0	1	36	0	0.02	1245	2294	22	0	0	0	1	25	0.00	0.00	0.02	99.95	1.04
0	2	8	0	0.02	1390	2294	22	0	0	0	0	27	0.00	0.00	0.00	99.97	0.37	99.61	32
0	2	40	0	0.03	1392	2294	24	0	0	0	0	36	0.00	0.00	0.00	99.96	0.36
0	3	12	0	0.02	1348	2294	23	0	0	0	0	26	0.00	0.00	0.00	99.97	0.23	99.76	36


root@troll-4:/home/jlawall/spin# myturbostat --version
turbostat version 21.05.04 - Len Brown <lenb@kernel.org>
root@troll-4:/home/jlawall/spin# head troll_new_turbo
5.014223 sec
Package	Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IPC	IRQ	SMI	POLL	C1	C1E	C6	POLL%	C1%	C1E%	C6%	CPU%c1	CPU%c6	CoreTmp	PkgTmp	Pkg%pc2	Pkg%pc6	Pkg_J	RAM_J	PKG_%	RAM_%
-	-	-	61	1.58	3863	2294	1.00	2800	0	0	27	68	1927	0.00	0.02	0.02	98.37	2.14	96.28	37	39	46.29	0.00	457.55	335.42	0.00	0.00
0	0	0	5	0.44	1054	2295	0.63	351	0	0	0	0	668	0.00	0.00	0.00	99.63	4.53	95.04	34	39	92.52	0.00	225.67	166.64	0.00	0.00
0	0	32	1	0.05	1060	2295	0.12	25	0	0	0	1	25	0.00	0.00	0.02	99.97	4.91
0	1	4	0	0.01	1461	2295	0.38	6	0	0	0	1	6	0.00	0.00	0.01	99.97	0.19	99.80	33
0	1	36	0	0.02	1295	2295	0.56	19	0	0	0	2	15	0.00	0.00	0.04	99.94	0.18
0	2	8	0	0.01	1764	2295	0.31	9	0	0	0	1	10	0.00	0.00	0.01	99.98	0.18	99.81	30
0	2	40	0	0.01	1761	2295	0.32	10	0	0	0	2	15	0.00	0.00	0.03	99.95	0.18
0	3	12	0	0.03	1304	2295	0.41	32	0	0	0	21	42	0.00	0.00	0.62	99.35	0.95	99.02	35


It seems that the problem was not limited to machines with persuistent
memory.  Here are the same results on a 4-socket 6130:

Old version:
root@yeti-4:/home/jlawall/spin# head yeti_turbo
5.031399 sec
Package	Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IRQ	SMI	POLL	C1	C1E	C6	POLL%	C1%	C1E%	C6%	CPU%c1	CPU%c6	CoreTmp	PkgTmp	Pkg%pc2	Pkg%pc6	PkgWatt	RAMWatt	PKG_%	RAM_%
-	-	-	29	0.80	3630	2096	4751	0	0	8	56	3585	0.00	0.00	0.01	99.23	1.23	97.97	30	31	72.53	0.00	193.12	111.17	0.00	0.00
0	0	0	4	0.41	1027	2095	290	0	0	0	10	536	0.00	0.00	0.66	98.98	4.19	95.40	28	31	92.84	0.00	44.66	25.49	0.00	0.00
0	0	64	0	0.04	1073	2095	9	0	0	0	0	9	0.00	0.00	0.00	99.98	4.56
0	1	8	0	0.01	1922	2095	9	0	0	0	0	10	0.00	0.00	0.00	99.99	0.23	99.76	29
0	1	72	0	0.02	1380	2095	27	0	0	0	0	29	0.00	0.00	0.00	99.98	0.22
0	2	16	0	0.02	1574	2095	24	0	0	0	0	26	0.00	0.00	0.00	99.98	0.91	99.07	29
0	2	80	0	0.03	1290	2095	55	0	0	8	1	45	0.00	0.58	0.04	99.36	0.90
0	3	24	0	0.02	1460	2095	34	0	0	0	8	30	0.00	0.00	0.59	99.39	0.83	99.15	29

New version:
root@yeti-4:/home/jlawall/spin# head yeti_new_turbo
5.030216 sec
Package	Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IPC	IRQ	SMI	POLL	C1	C1E	C6	POLL%	C1%	C1E%	C6%	CPU%c1	CPU%c6	CoreTmp	PkgTmp	Pkg%pc2	Pkg%pc6	PkgWatt	RAMWatt	PKG_%	RAM_%
-	-	-	51	1.49	3427	2107	1.04	23135	0	8	1524	2664	23370	0.00	0.07	0.22	98.79	5.71	92.80	31	32	59.79	0.00	205.38	30.23	0.00	0.00
0	0	0	7	0.52	1312	2095	0.56	397	0	0	0	3	690	0.00	0.00	0.01	99.53	5.58	93.90	29	32	80.47	0.00	45.69	6.78	0.00	0.00
0	0	64	1	0.04	1278	2095	0.10	9	0	0	0	0	11	0.00	0.00	0.00	99.99	6.06
0	1	8	3	0.12	2865	2095	0.71	44	0	0	0	1	51	0.00	0.00	0.00	99.88	0.64	99.24	30
0	1	72	0	0.01	1835	2095	0.30	18	0	0	0	0	18	0.00	0.00	0.00	99.99	0.75
0	2	16	0	0.02	1537	2095	0.16	8	0	0	0	0	9	0.00	0.00	0.00	99.99	12.87	87.11	29
0	2	80	38	2.08	1847	2095	0.16	8262	0	3	1426	98	6552	0.00	6.45	0.12	91.60	10.81
0	3	24	0	0.01	2043	2095	0.24	9	0	0	0	0	13	0.00	0.00	0.00	99.99	1.41	98.58	30

On the other hand, the energy consumption is still much higher on the
machine with the persistent memory, even though the persistent memory is
not being used.  But I guess it is reasonable that it should still consume
something.

thanks,
julia
