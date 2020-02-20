Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB66166369
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 17:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgBTQst (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 11:48:49 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:18953 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgBTQss (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 11:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1582217328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bXLHsjHJlcKALrV/t0FOsbyYb0NM5JDeWeMd5J+IqEs=;
  b=CISoXVWGeoCVm6W2mXDsfBo4tSPszNOJZ5TQutwQRZ76XTmOQLs8KfAU
   3VvaA/WOnJwEJFM45TbA5lnahyNOrDHdBxsbce0MAMJsopZa4BTvbbhBZ
   ILcpINbJ1ryNyBEm0kiUNHN2nU5GYNpELr/akYbWhw/0+uMHyn2ot+iAK
   M=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: AtNmaeOI/KPiKNAzF3WkeY3GtDkzuuQSQiqjhnBfavLAIAOQjUZfpVAGmAZeMyQ1/y+M/W/MhZ
 rTwBfhThzqxv2OUa8kotAWC3zsel0hBZlPR6Y2QDEvs7B0oWgrUmy2o/zJPUWbLWmmM7LxC/e3
 j6XbUC12D1wMfgS/J6jnVwBxE5tbo+eeRE6ianJaDUUHYlUfSjhXpUKqphkniiteWuB8BaNVLW
 yC+pEY9uoteYc54GvU2s9VLuJdP1fOQubi4Q5XzPjdx9AmqfKLeDRF44NvNmmQopcALDtBSiXF
 S7c=
X-SBRS: 2.7
X-MesageID: 12749991
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,465,1574139600"; 
   d="scan'208";a="12749991"
Date:   Thu, 20 Feb 2020 17:48:39 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     "Durrant, Paul" <pdurrant@amazon.co.uk>
CC:     "Agarwal, Anchal" <anchalag@amazon.com>,
        "Valentin, Eduardo" <eduval@amazon.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "fllinden@amaozn.com" <fllinden@amaozn.com>,
        "Kamata, Munehisa" <kamatam@amazon.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [Xen-devel] [RFC PATCH v3 06/12] xen-blkfront: add callbacks for
 PM suspend and hibernation
Message-ID: <20200220164839.GR4679@Air-de-Roger>
References: <cover.1581721799.git.anchalag@amazon.com>
 <890c404c585d7790514527f0c021056a7be6e748.1581721799.git.anchalag@amazon.com>
 <20200217100509.GE4679@Air-de-Roger>
 <20200217230553.GA8100@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <20200218091611.GN4679@Air-de-Roger>
 <20200219180424.GA17584@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <20200220083904.GI4679@Air-de-Roger>
 <f986b845491b47cc8469d88e2e65e2a7@EX13D32EUC003.ant.amazon.com>
 <20200220154507.GO4679@Air-de-Roger>
 <c9662397256a4568a5cc7d70a84940e5@EX13D32EUC003.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9662397256a4568a5cc7d70a84940e5@EX13D32EUC003.ant.amazon.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 04:23:13PM +0000, Durrant, Paul wrote:
> > -----Original Message-----
> > From: Roger Pau Monné <roger.pau@citrix.com>
> > Sent: 20 February 2020 15:45
> > To: Durrant, Paul <pdurrant@amazon.co.uk>
> > Cc: Agarwal, Anchal <anchalag@amazon.com>; Valentin, Eduardo
> > <eduval@amazon.com>; len.brown@intel.com; peterz@infradead.org;
> > benh@kernel.crashing.org; x86@kernel.org; linux-mm@kvack.org;
> > pavel@ucw.cz; hpa@zytor.com; tglx@linutronix.de; sstabellini@kernel.org;
> > fllinden@amaozn.com; Kamata, Munehisa <kamatam@amazon.com>;
> > mingo@redhat.com; xen-devel@lists.xenproject.org; Singh, Balbir
> > <sblbir@amazon.com>; axboe@kernel.dk; konrad.wilk@oracle.com;
> > bp@alien8.de; boris.ostrovsky@oracle.com; jgross@suse.com;
> > netdev@vger.kernel.org; linux-pm@vger.kernel.org; rjw@rjwysocki.net;
> > linux-kernel@vger.kernel.org; vkuznets@redhat.com; davem@davemloft.net;
> > Woodhouse, David <dwmw@amazon.co.uk>
> > Subject: Re: [Xen-devel] [RFC PATCH v3 06/12] xen-blkfront: add callbacks
> > for PM suspend and hibernation
> > 
> > On Thu, Feb 20, 2020 at 08:54:36AM +0000, Durrant, Paul wrote:
> > > > -----Original Message-----
> > > > From: Xen-devel <xen-devel-bounces@lists.xenproject.org> On Behalf Of
> > > > Roger Pau Monné
> > > > Sent: 20 February 2020 08:39
> > > > To: Agarwal, Anchal <anchalag@amazon.com>
> > > > Cc: Valentin, Eduardo <eduval@amazon.com>; len.brown@intel.com;
> > > > peterz@infradead.org; benh@kernel.crashing.org; x86@kernel.org; linux-
> > > > mm@kvack.org; pavel@ucw.cz; hpa@zytor.com; tglx@linutronix.de;
> > > > sstabellini@kernel.org; fllinden@amaozn.com; Kamata, Munehisa
> > > > <kamatam@amazon.com>; mingo@redhat.com; xen-
> > devel@lists.xenproject.org;
> > > > Singh, Balbir <sblbir@amazon.com>; axboe@kernel.dk;
> > > > konrad.wilk@oracle.com; bp@alien8.de; boris.ostrovsky@oracle.com;
> > > > jgross@suse.com; netdev@vger.kernel.org; linux-pm@vger.kernel.org;
> > > > rjw@rjwysocki.net; linux-kernel@vger.kernel.org; vkuznets@redhat.com;
> > > > davem@davemloft.net; Woodhouse, David <dwmw@amazon.co.uk>
> > > > Subject: Re: [Xen-devel] [RFC PATCH v3 06/12] xen-blkfront: add
> > callbacks
> > > > for PM suspend and hibernation
> > > >
> > > > Thanks for this work, please see below.
> > > >
> > > > On Wed, Feb 19, 2020 at 06:04:24PM +0000, Anchal Agarwal wrote:
> > > > > On Tue, Feb 18, 2020 at 10:16:11AM +0100, Roger Pau Monné wrote:
> > > > > > On Mon, Feb 17, 2020 at 11:05:53PM +0000, Anchal Agarwal wrote:
> > > > > > > On Mon, Feb 17, 2020 at 11:05:09AM +0100, Roger Pau Monné wrote:
> > > > > > > > On Fri, Feb 14, 2020 at 11:25:34PM +0000, Anchal Agarwal
> > wrote:
> > > > > > > Quiescing the queue seemed a better option here as we want to
> > make
> > > > sure ongoing
> > > > > > > requests dispatches are totally drained.
> > > > > > > I should accept that some of these notion is borrowed from how
> > nvme
> > > > freeze/unfreeze
> > > > > > > is done although its not apple to apple comparison.
> > > > > >
> > > > > > That's fine, but I would still like to requests that you use the
> > same
> > > > > > logic (as much as possible) for both the Xen and the PM initiated
> > > > > > suspension.
> > > > > >
> > > > > > So you either apply this freeze/unfreeze to the Xen suspension
> > (and
> > > > > > drop the re-issuing of requests on resume) or adapt the same
> > approach
> > > > > > as the Xen initiated suspension. Keeping two completely different
> > > > > > approaches to suspension / resume on blkfront is not suitable long
> > > > > > term.
> > > > > >
> > > > > I agree with you on overhaul of xen suspend/resume wrt blkfront is a
> > > > good
> > > > > idea however, IMO that is a work for future and this patch series
> > should
> > > > > not be blocked for it. What do you think?
> > > >
> > > > It's not so much that I think an overhaul of suspend/resume in
> > > > blkfront is needed, it's just that I don't want to have two completely
> > > > different suspend/resume paths inside blkfront.
> > > >
> > > > So from my PoV I think the right solution is to either use the same
> > > > code (as much as possible) as it's currently used by Xen initiated
> > > > suspend/resume, or to also switch Xen initiated suspension to use the
> > > > newly introduced code.
> > > >
> > > > Having two different approaches to suspend/resume in the same driver
> > > > is a recipe for disaster IMO: it adds complexity by forcing developers
> > > > to take into account two different suspend/resume approaches when
> > > > there's no need for it.
> > >
> > > I disagree. S3 or S4 suspend/resume (or perhaps we should call them
> > power state transitions to avoid confusion) are quite different from Xen
> > suspend/resume.
> > > Power state transitions ought to be, and indeed are, visible to the
> > software running inside the guest. Applications, as well as drivers, can
> > receive notification and take whatever action they deem appropriate.
> > > Xen suspend/resume OTOH is used when a guest is migrated and the code
> > should go to all lengths possible to make any software running inside the
> > guest (other than Xen specific enlightened code, such as PV drivers)
> > completely unaware that anything has actually happened.
> > 
> > So from what you say above PM state transitions are notified to all
> > drivers, and Xen suspend/resume is only notified to PV drivers, and
> > here we are speaking about blkfront which is a PV driver, and should
> > get notified in both cases. So I'm unsure why the same (or at least
> > very similar) approach can't be used in both cases.
> > 
> > The suspend/resume approach proposed by this patch is completely
> > different than the one used by a xenbus initiated suspend/resume, and
> > I don't see a technical reason that warrants this difference.
> >
> 
> Within an individual PV driver it may well be ok to use common mechanisms for connecting to the backend but issues will arise if any subsequent action is visible to the guest. E.g. a network frontend needs to issue gratuitous ARPs without anything else in the network stack (or monitoring the network stack) knowing that it has happened. 
>  
> > I'm not saying that the approach used here is wrong, it's just that I
> > don't see the point in having two different ways to do suspend/resume
> > in the same driver, unless there's a technical reason for it, which I
> > don't think has been provided.
> 
> The technical justification is that the driver needs to know what kind of suspend or resume it is doing, so that it doesn't do the wrong thing. There may also be differences in the state of the system e.g. in Windows, at least some of the resume-from-xen-suspend code runs with interrupts disabled (which is necessary to make sure enough state is restored before things become visible to other kernel code).
> 
> > 
> > I would be fine with switching xenbus initiated suspend/resume to also
> > use the approach proposed here: freeze the queues and drain the shared
> > rings before suspending.
> > 
> 
> I think abstracting away at the xenbus level to some degree is probably feasible, but some sort of flag should be passed to the individual drivers so they know what circumstances they are operating under.
> 
> > > So, whilst it may be possible to use common routines to, for example,
> > re-establish PV frontend/backend communication, PV frontend code should be
> > acutely aware of the circumstances they are operating in. I can cite
> > example code in the Windows PV driver, which have supported guest S3/S4
> > power state transitions since day 1.
> > 
> > Hm, please bear with me, as I'm not sure I fully understand. Why isn't
> > the current suspend/resume logic suitable for PM transitions?
> > 
> 
> I don’t know the details for Linux but it may well be to do with assumptions made about the system e.g. the ability to block waiting for something to happen on another CPU (which may have already been quiesced in a PM context).
> 
> > As said above, I'm happy to switch xenbus initiated suspend/resume to
> > use the logic in this patch, but unless there's a technical reason for
> > it I don't see why blkfront should have two completely different
> > approaches to suspend/resume depending on whether it's a PM or a
> > xenbus state change.
> > 
> 
> Hopefully what I said above illustrates why it may not be 100% common.

Yes, that's fine. I don't expect it to be 100% common (as I guess
that the hooks will have different prototypes), but I expect
that routines can be shared, and that the approach taken can be the
same.

For example one necessary difference will be that xenbus initiated
suspend won't close the PV connection, in case suspension fails. On PM
suspend you seem to always close the connection beforehand, so you
will always have to re-negotiate on resume even if suspension failed.

What I'm mostly worried about is the different approach to ring
draining. Ie: either xenbus is changed to freeze the queues and drain
the shared rings, or PM uses the already existing logic of not
flushing the rings an re-issuing in-flight requests on resume.

Thanks, Roger.
