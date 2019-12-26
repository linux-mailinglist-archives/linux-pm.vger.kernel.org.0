Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17812AE68
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2019 21:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLZU0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 15:26:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44861 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfLZU0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Dec 2019 15:26:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so24467016wrm.11;
        Thu, 26 Dec 2019 12:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9U7JTfD4fduXLjfQ1Xx2mG/4Nq5G+aypGi2uRZjCndQ=;
        b=Y+/E7sdISgFCod6NdnHJW479g8MbWWiNgwWpI5rVpokct4dLSn3EClz4zxD5nUcwHG
         849iZdjDWcPvqsDGib5WzIiUhGuLV+apNaE8wxvr6ziNcMBV04P+eNSrmZheHrP9KoN5
         1f56JreZqERgJjZe2LLqBOpErT4GWmzWRSJapOT42TkPWV/3Nch5oKXTNI6qsQQJw59Q
         /SD+GdekkD7sWS3z770vw6CkDlXPFk3WkuhXb23RpwdtmICcNf6wxMByJxP80Jo5J9kp
         0QXxbYyDDSjx+3bMkRs9XA5u47uWRz2SYIF9gBE9sbvQScuTJXiC3PGYpDnBV72LD6QP
         75xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9U7JTfD4fduXLjfQ1Xx2mG/4Nq5G+aypGi2uRZjCndQ=;
        b=sM5XWbGwh/7bJGfRikfU/udgLvgul2dQ3PsmWuoGHldjpfaeF4bOnE3OdP2IcPSEBc
         dZ5vRR5odWui31telM2zl9podv8TjcnBTwuqzxnvs2V9ImgnHpilv1TG02bG6xRMgS3V
         S97AckqI4U+qZ4OkcApmr5sQn7I6DrYNak7Kuv2xq1FamwzzDgR6iZB4fbIQy7K6YXow
         wcfCMDx7D/r4r8+UifwukB9ao8OKRsq6pVQ/PkQa3yKB26o1HrsroEsEYMMSfH8z7VXg
         rAeMcXrVECVs09iMXAleUE3TwEKKqTFSKwER36jKo6xXVwkLlswP4awcBCG2oxD4jjWq
         cV2g==
X-Gm-Message-State: APjAAAXb1d9dcowY+vAvZldMfcj2uPbvWdriGYMcMrYf8PHl+RzCzS+I
        vT6kqdJkzF4ncQ16pbIEfQmI9LPe
X-Google-Smtp-Source: APXvYqwcuB8ziCCtYYFgDEUXH4mvcKEbxT76KLDcss6Q4USj5UvoJ3HbyoEmisuUoyobLrZHRGuolA==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr46714621wrq.176.1577391971163;
        Thu, 26 Dec 2019 12:26:11 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id o129sm9470927wmb.1.2019.12.26.12.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 12:26:10 -0800 (PST)
Date:   Thu, 26 Dec 2019 21:26:07 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
Message-ID: <20191226202607.GA9524@Red>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
 <20191219173321.bni4tbrhfkkphv7k@gilmour.lan>
 <4015380d-33ef-312c-a886-6e8bf65c976a@linaro.org>
 <20191226092751.dc3boaxsaeivuhw4@hendrix.home>
 <20191226104419.GA26677@Red>
 <CAEExFWtNZM3QSSMEksK=-opKZqxvCqyG2=3=iCo3VU6tfie64w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEExFWtNZM3QSSMEksK=-opKZqxvCqyG2=3=iCo3VU6tfie64w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 26, 2019 at 08:47:47PM +0800, Frank Lee wrote:
> On Thu, Dec 26, 2019 at 6:44 PM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> >
> > On Thu, Dec 26, 2019 at 10:27:51AM +0100, Maxime Ripard wrote:
> > > On Tue, Dec 24, 2019 at 07:30:55PM +0100, Daniel Lezcano wrote:
> > > > On 19/12/2019 18:33, Maxime Ripard wrote:
> > > > > Hi,
> > > > >
> > > > > On Thu, Dec 19, 2019 at 09:28:16AM -0800, Vasily Khoruzhick wrote:
> > > > >> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> > > > >> H6 and R40 SoCs.
> > > > >
> > > > > Thanks again for working on this.
> > > > >
> > > > > I'll merge the DT patches when the driver will have been merged.
> > > >
> > > > I've applied patches 1 & 2.
> > > >
> > > > They are in the testing branch and will go to the linux-next branch as
> > > > soon as the kernelci passes.
> > >
> > > I just merged all the other patches (except the patch 6, for the H6,
> > > as requested by Vasily on IRC).
> > >
> >
> > Hello
> >
> > Vasily asked to not apply H6 due to my test failling on h6 and since he didnt own any H6 hw.
> > But it was failling due my fault (a failling build).
> >
> > So the patchset work perfect on H6 (opi1+, opi3, pineH64 both model A and B) as reported by my answer to this thread.
> 
> HI Corentin,
> 
> Although it is not calibrated, it should work on the R40. Can you give
> my patch a try?
> 

Hello

It is planned, I will report the result.

Regards
