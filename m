Return-Path: <linux-pm+bounces-41499-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNBfH3/Od2mxlQEAu9opvQ
	(envelope-from <linux-pm+bounces-41499-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 21:28:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1F98D126
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 21:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 943083032CF4
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 20:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAA32D6E66;
	Mon, 26 Jan 2026 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sVOFTFwR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C02D46BD
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459274; cv=none; b=CDii76pc07ewbLHmKC3VS8RjFo95yzaTXeIi9gK6bwpcrXtcwRjq4xzDURMuAdzyF3lEt7s6lr6TxlOhUcorJWMZ/bSfctEkAh9nCDZ2Vg6beZYXZWgl0rSah7tH1myDH9cSh51NorKteXHSx25MTwDB3NqG5FSLM7J6xhnTSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459274; c=relaxed/simple;
	bh=hvO+XbRf3Yc0UjJqdckcSDxvcdiGziyQmypcq1TFw74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NXmHn3X2XTg1LFyGJLXR5ApRP72mot2qYJzqUQ0KLo0IhGeEgh12CWLCIENNS63rA1wmXF9cLiFbcrnvCiRlKmPDA+D3R9yeLAJRTJV9gSgjIux7rEN4QIt2Su4rUj8wD6TpAusS4QZgfGMOl6RGxWwMAeQRQbA0azA13FaTrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sVOFTFwR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a94c6d4fso22840055ad.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 12:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769459271; x=1770064071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJxcoLWTIcLGT5eswWQAojarEYthG4I3ofXDOywAffE=;
        b=sVOFTFwRHIuf1iCgf/KG+kvIc0/k1mlaePdioxvkCmiDrqi6B2zzbBW6C7n1hY58So
         wPt0fFVAXQX9QuDetjRrJ1kMl6ydAyZ+f8wtr4mfJ88GxhC+hsTjw+uJWPPW9vJ5fakw
         kBq0mQjigIXV92igBjtBy56PyXs/PJ2KxMx9NOMLuenU/Jw6zg2YMrWkP2qcBhOBjQQu
         rkAJYhwh541/dcjWVeTYmqakqBSzdNi3pYPuiK5TG8rqxcAZZ3/rVRigy9L3CZ/JjJaG
         bqTIQvZCOQsYX2uMfJsk+1sg2qIZH71A/QBDRhKS1+++my8HLhZqHVWd0gLZ2OKNbX6I
         I3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769459271; x=1770064071;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pJxcoLWTIcLGT5eswWQAojarEYthG4I3ofXDOywAffE=;
        b=Fj2A7HBDwuwUACixKsuLYeVd3986w9+duPmciq9UViMBd4Cjuq79gCuhDOa9/9iogf
         AqW7++rNt+2QNLCWbVtGgnAFB4zr8bci82ynj5HdTm6TSGPLjO5h3SdloCmLXGqvobtf
         KukNz1Yr8YFvLhIkmAyN2NrTPM6ATZj8ACFQgaSVcHMsPDaba7Mcw2uQhgJYhGjKpQWd
         SeqJWNvAcLkap73rFst7eSd/jgXnTAHmRVuJXkHarVncTb/h3N4J9HfeELBerwr+MG6q
         uRIXP0VzpCLEJnrLGAwfait14Z8XpmmgCebPMvHcvM7P/7qTwfeXvO1b/lmJFR05HV4n
         BXWA==
X-Forwarded-Encrypted: i=1; AJvYcCWl392XLgf6wW3lk6ouofSLBXoz4ESAplL5GlktefZaCKciFfSuWLW269bK3Bp9XHTQgGudHqwYBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEEbsfteLSkeFzX0acHaRKyiQBkIzwo8y0vK/VGF4BmQXNTKDY
	iBEuvUyb7nh9239T2WAkavUtMdGsC2NdyFAwFwjh8OMi54xuCvCXzk0qRT5HXLmr5G0=
X-Gm-Gg: AZuq6aKJijHdxkNWUrVqOWno+JyJcuNRKULvGIzpMI5wDEiQRzFakawO9ifxNMlQyh/
	K6MFXuRQfrRK/QDIG6cfgZdaMocHVlgOD1jp5rzlRlhIApdxBNpOaLViEQDknv8pXDqZ+McP8fh
	gZbpq/AjA+OfMvTmrUvPPyMK5/A+4FSKpHZLE0RLXxIjxkIHV2vs3rYPtnZjZgB5USXTlGUZ3/R
	vw2O2fOokMg897Jx7vV90/SOR8NvXc+O2bMvcG85ImlO4ElllXBZjuo+oLsXMkLaBIvZGWKa3Ys
	s7DYk6DqYVmNg+vPZ3FqPchEMnSzWpKaIUe6tooUyxs9Y33lJk1xhrxpefgVm//nsKv8SK+mhg0
	DX4Bz4VLkezcjO37mr2UxXbR0VVAecWx8bliviUWCoCMhLpmr1VJLLuCRVc0G2cFBJL2nqv281M
	ik+8KqO0l+
X-Received: by 2002:a17:902:f541:b0:29f:301a:f6cf with SMTP id d9443c01a7336-2a8452f0c27mr58766155ad.35.1769459270603;
        Mon, 26 Jan 2026 12:27:50 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcd776sm95257565ad.26.2026.01.26.12.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 12:27:50 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Rob Herring <robh@kernel.org>, Herve Codina <herve.codina@bootlin.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2] of: Add of_parse_map_iter() helper for nexus
 node map iteration
In-Reply-To: <CAL_JsqLq1V_is4wHedFoiGHcYt293vDJ4SsHaZKxYARupbUXEw@mail.gmail.com>
References: <20260121-topic-lpm-of-map-iterator-v6-18-v2-1-a40bf8e91045@baylibre.com>
 <CAL_JsqLq1V_is4wHedFoiGHcYt293vDJ4SsHaZKxYARupbUXEw@mail.gmail.com>
Date: Mon, 26 Jan 2026 12:27:49 -0800
Message-ID: <7hh5s85dbu.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41499-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.214.178:received,71.212.200.220:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,parent_args.np:url,msgid.link:url,baylibre.com:mid,baylibre.com:email,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1F1F98D126
X-Rspamd-Action: no action

Rob Herring <robh@kernel.org> writes:

> On Wed, Jan 21, 2026 at 5:55=E2=80=AFPM Kevin Hilman (TI) <khilman@baylib=
re.com> wrote:
>>
>> Add a new helper function of_parse_map_iter() to simplify parsing of
>> nexus node maps as defined in the DT spec, section 2.5.1.
>>
>> This function provides an iterator interface for traversing map entries,
>> handling the complexity of variable-sized entries based on #<stem>-cells
>> properties. Each map entry follows the format:
>>   <child_specifier phandle parent_specifier>
>>
>> The iterator extracts both the child specifier and parent phandle+args
>> for each entry, managing all the details of:
>> - Reading #<stem>-cells from both child and parent nodes
>> - Calculating variable entry sizes
>> - Resolving phandles
>> - Proper node reference management
>>
>> This eliminates the need for subsystems to manually parse map properties,
>> reducing code duplication and potential bugs.
>>
>> This code was developed in collaboration with Claude Code (model:
>> Sonnet 4.5), which needed some guidance to use existing OF helpers,
>> iterators etc.
>>
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>> Changes in v2:
>> - Use helpers of_phandle_iterator_init() and of_phandle_iterator_next()
>> - add missing of_node_put() pointed out in v1
>> - Link to v1: https://patch.msgid.link/20251119-topic-lpm-of-map-iterato=
r-v6-18-v1-1-1f0075d771a3@baylibre.com
>> ---
>>  drivers/of/base.c  | 163 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/of.h |  13 +++++++++++++
>>  2 files changed, 176 insertions(+)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 0b65039ece53..8392fe54cf60 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -1641,6 +1641,169 @@ int of_parse_phandle_with_args_map(const struct =
device_node *np,
>>  }
>>  EXPORT_SYMBOL(of_parse_phandle_with_args_map);
>>
>> +/**
>> + * of_parse_map_iter() - Iterate through entries in a nexus node map
>> + * @np:                        pointer to a device tree node containing=
 the map
>> + * @stem_name:         stem of property names (e.g., "power-domain" for=
 "power-domain-map")
>> + * @index:             pointer to iteration index (set to 0 for first c=
all)
>> + * @child_args:                pointer to structure to fill with child =
specifier (can be NULL)
>> + * @parent_args:       pointer to structure to fill with parent phandle=
 and specifier
>> + *
>> + * This function iterates through a nexus node map property as defined =
in DT spec 2.5.1.
>> + * Each map entry has the format: <child_specifier phandle parent_speci=
fier>
>> + *
>> + * On each call, it extracts one map entry and fills child_args (if pro=
vided) with the
>> + * child specifier and parent_args with the parent phandle and specifie=
r.
>> + * The index pointer is updated to point to the next entry for the foll=
owing call.
>> + *
>> + * Example usage::
>> + *
>> + *  int index =3D 0;
>> + *  struct of_phandle_args child_args, parent_args;
>> + *
>> + *  while (!of_parse_map_iter(np, "power-domain", &index, &child_args, =
&parent_args)) {
>> + *      // Process child_args and parent_args
>> + *      of_node_put(parent_args.np);
>> + *  }
>> + *
>> + * Caller is responsible for calling of_node_put() on parent_args.np.
>> + *
>> + * Return: 0 on success, -ENOENT when iteration is complete, or negativ=
e error code on failure.
>> + */
>> +int of_parse_map_iter(const struct device_node *np,
>> +                      const char *stem_name,
>> +                      int *index,
>> +                      struct of_phandle_args *child_args,
>> +                      struct of_phandle_args *parent_args)
>> +{
>> +       char *cells_name __free(kfree) =3D kasprintf(GFP_KERNEL, "#%s-ce=
lls", stem_name);
>> +       char *map_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map",=
 stem_name);
>> +       char *mask_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map-=
mask", stem_name);
>> +       char *pass_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map-=
pass-thru", stem_name);
>
> It's not great that we're doing allocs and frees on each iteration.
>
> Can't we follow the same design Herve did for interrupt-map? You have
> an init function you call once up front and then an iterator define
> (e.g. for_each_of_imap_item()). The complication in this case would be
> if we do the allocs in the init function, then we need a way to free
> them. If they are part of the for loop init, then we could use the
> scoped cleanup.
>
> On thing I noticed is I think of_phandle_iterator and of_imap_parser
> should probably be merged to one struct. They basically hold the same
> information (pointers to property data).
>
> Let me see if I can come up with something next week.

Thank you!

I would greatly appreciate some help getting this going in the right
direction as I'm definitely out of my comfort zone in this drivers/of
code.

Kevin

