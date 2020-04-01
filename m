Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0E19B5EA
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 20:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgDASsx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 14:48:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43413 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbgDASsx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 14:48:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id f206so423662pfa.10
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2020 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulhOw4stYNMJI54bH35cjH5xFB2S7Dajjn042iFhlAk=;
        b=ln2+bUNX3IYbT39875VObE1yUtmBMva3t4VVBd1h9kJmOV5CiaWYRaASBOMr0NFMWN
         QM7pjk832AFgMpB5ZMjur7BjF2+e32lnw1K11fT2ieeFUKBUi2Bm/kQUx+fU9iNsj5f3
         6A+staF/q7hNn90hN55oTFJbZJksRHC+anShor0skqvE4bN/jAW51494pJ7FxhYVjtkf
         dVFjMvS+KfQQAuE6uJXxXsjmuuclN9ATmat2zYkjOxE703XanidHkvKNXFgHb0NI+4tn
         X62wHa1LXJmZI96g93oPzlX+d1HHgTLRR3IhoBza2ajxtaG8q9gJemPc74aEujN3ywvv
         zeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulhOw4stYNMJI54bH35cjH5xFB2S7Dajjn042iFhlAk=;
        b=G0cC4sRtTCFLPO9lQtWEz27WKfZwdfeXM4OisgaF5W7kJozAmYxCDuuQ3TGoe+cUBz
         uRy1XXdJlFaODZ5A8qY7DKVB4XMkx65vby7PsJA8dnOttZ3uSpMDPEZVo9cK8EmnSs8B
         HRrYlguH34iwZYqYjoJLJTg7ixbwEa8LS9wZZUqlWWaXUhlBwk/R1ljFuRlqhcem2/+N
         UZUCY7OBwrYJHfyvGlKuRFXtzzqkWZ2UMl36CLgAh8xTRUdEXV75KGtQaofAIvpV7ecR
         ESn8DjQTZeOZN0deIHXkjXAGMHo8HoAiLyitTDPl1749YjmAVYtCtOSCjx2mHTU7mumz
         MrPg==
X-Gm-Message-State: AGi0PubcIC7/U/RiWaCSmOmkGGkzqZ+sILZfkjrWkT9nYH6r/dHV18yc
        Fiij/bOAzYZAosEUGzDZC76LLg76thG0MQcHaKe9yw==
X-Google-Smtp-Source: APiQypI2HZUUxGoH2263hX+0V33Waac14jbJ/InoRrxuPaarHNJHGn8YvcMK3io31gtf28si3KlZBW+Hl7Z/YFLOgbI=
X-Received: by 2002:aa7:99cd:: with SMTP id v13mr20824814pfi.106.1585766931503;
 Wed, 01 Apr 2020 11:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
 <285da2166eadc1d46667dd9659d8dae74d28b0b9.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFd5g460hY9uOtwicWHK2rhgLdL+gStbKGmLN5KLWi5JXDQEog@mail.gmail.com> <4f915b8b8bee36a61ebea62ebf34c61845170ad5.camel@fi.rohmeurope.com>
In-Reply-To: <4f915b8b8bee36a61ebea62ebf34c61845170ad5.camel@fi.rohmeurope.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 1 Apr 2020 11:48:40 -0700
Message-ID: <CAFd5g44gBrNti5Y_ctQKOE1_pWX3NAdTji1uH8m6dGj+tsJCew@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] lib/test_linear_ranges: add a test for the 'linear_ranges'
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "talgi@mellanox.com" <talgi@mellanox.com>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davidgow@google.com" <davidgow@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "bp@suse.de" <bp@suse.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        "uwe@kleine-koenig.org" <uwe@kleine-koenig.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 1, 2020 at 1:45 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
>
> Hello Brendan,
>
> Thanks for taking a look at this :) Much appreciated! I have always
> admired you guys who have the patience to do all the reviewing... It's
> definitely not my favourite job :/

Huh, you know, I thought the same thing like 3 years ago. I guess it
got the point where I had to do reviews for the things I maintained
that I got used to it. Then I got to a point where I was requesting so
many reviews from others that I felt that I owed the community
reviews. So no thanks necessary, I feel that I am just paying it
forward. :-)

> On Tue, 2020-03-31 at 11:08 -0700, Brendan Higgins wrote:
> > On Tue, Mar 31, 2020 at 5:23 AM Matti Vaittinen
> > <matti.vaittinen@fi.rohmeurope.com> wrote:
> > >     Add a KUnit test for the linear_ranges helper.
> > >
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> >
> > One minor nit, other than that:
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > > ---
> > >
>
> /// Snip
>
> > > +
> > > +/* First things first. I deeply dislike unit-tests. I have seen
> > > all the hell
> > > + * breaking loose when people who think the unit tests are "the
> > > silver bullet"
> > > + * to kill bugs get to decide how a company should implement
> > > testing strategy...
> > > + *
> > > + * Believe me, it may get _really_ ridiculous. It is tempting to
> > > think that
> > > + * walking through all the possible execution branches will nail
> > > down 100% of
> > > + * bugs. This may lead to ideas about demands to get certain % of
> > > "test
> > > + * coverage" - measured as line coverage. And that is one of the
> > > worst things
> > > + * you can do.
> > > + *
> > > + * Ask people to provide line coverage and they do. I've seen
> > > clever tools
> > > + * which generate test cases to test the existing functions - and
> > > by default
> > > + * these tools expect code to be correct and just generate checks
> > > which are
> > > + * passing when ran against current code-base. Run this generator
> > > and you'll get
> > > + * tests that do not test code is correct but just verify nothing
> > > changes.
> > > + * Problem is that testing working code is pointless. And if it is
> > > not
> > > + * working, your test must not assume it is working. You won't
> > > catch any bugs
> > > + * by such tests. What you can do is to generate a huge amount of
> > > tests.
> > > + * Especially if you were are asked to proivde 100% line-coverage
> > > x_x. So what
> > > + * does these tests - which are not finding any bugs now - do?
> >
> > I don't entirely disagree. I have worked on projects that do testing
> > well where it actually makes development faster, and I have worked on
> > projects that do testing poorly where it never improves code quality
> > and is just an encumbrance, and I have never seen a project get to
> > 100% coverage (nor would I want to).
> >
> > Do you feel differently about incremental coverage vs. absolute
> > coverage? I have found incremental coverage to be a lot more valuable
> > in my experiences.
>
> I think I have only been dealing with projects measuring absolute
> coverage. I think seeing a coverage as %-number is mostly not
> interesting to me. What I think could be interesting is showing the
> code-paths test has walked through. I believe that code spots that
> should be tested should be hand picked by a human. When we look at any
> %-number, we do not know what kind of code the test has tested.

Ah, okay, code coverage by functions called is a thing and GCOV + LCOV
for the Linux kernel can actually give these nice reports that show
the code paths that have been executed. It requires a bit of manual
review, but I have found it pretty handy. Let me try to find you an
example...

> > You seem pretty passionate about this. Would you like to be included
> > in our unit testing discussions in the future?
>
> I think it would be nice :) I don't expect I will be active talker
> there but I really like to know what direction things are proceeding in
> general. And who knows, maybe I will have a word to say at times :) So
> please, include me if it is not a big thing for you.

Absolutely! Would you be interested in joining our mailing list:

https://groups.google.com/g/kunit-dev

> //Snip
>
> > > +
> > > +static void range_test_get_value(struct kunit *test)
> > > +{
> > > +       int ret, i;
> > > +       unsigned int sel, val;
> > > +
> > > +       for (i = 0; i < RANGE1_NUM_VALS; i++) {
> > > +               sel = range1_sels[i];
> > > +               ret = linear_range_get_value_array(&testr[0], 2,
> > > sel, &val);
> > > +               KUNIT_EXPECT_EQ(test, 0, ret);
> >
> > nit: It looks like the next line might crash if this expectation
> > fails. If this is the case, you might want to use a KUNIT_ASSERT_*
> > here.
>
> Huh. I re-read this and almost agreed with you. Then I re-re-read this
> and disagreed. Perhaps we should write an unit-test to test this ;)
>
> The range1_sels and range1_vals arrays should always be of same size.
> Thus the crash should not occur here. If RANGE1_NUM_VALS was bad then
> we would get the crash already at
>
> > > +               sel = range1_sels[i];
>
> The linear_range_get_value_array() may return non zero value if value
> contained in range1_sels[i] is not in the range - but range1_vals[i]
> should still be valid memory.

Got it. Sorry, I just assumed the second check was invalid if the
first one was invalid.

All looks good to me then!
